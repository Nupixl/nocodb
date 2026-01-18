import dns from 'node:dns';
import express from 'express';
import cors from 'cors';
import Noco from '../src/Noco';

dns.setDefaultResultOrder('ipv4first');

// Catch all uncaught errors
process.on('uncaughtException', (error) => {
  console.error('[FATAL] Uncaught Exception:', error);
  console.error('[FATAL] Stack:', error.stack);
});

process.on('unhandledRejection', (reason, promise) => {
  console.error('[ERROR] Unhandled Rejection at:', promise);
  console.error('[ERROR] Reason:', reason);
});

const app = express();
app.enable('trust proxy');
app.use(cors());
app.set('view engine', 'ejs');

let nocoApp: any = null;
let initializationPromise: Promise<any> | null = null;
let initError: Error | null = null;

async function initNoco() {
  console.log('[INIT] initNoco called, nocoApp:', !!nocoApp, 'initializationPromise:', !!initializationPromise);
  
  if (nocoApp) {
    console.log('[INIT] Returning cached nocoApp');
    return nocoApp;
  }
  
  if (initializationPromise) {
    console.log('[INIT] Waiting for existing initialization');
    return initializationPromise;
  }

  initializationPromise = (async () => {
    try {
      console.log('[INIT] Starting NocoDB initialization...');
      console.log('[ENV] NODE_ENV:', process.env.NODE_ENV);
      console.log('[ENV] VERCEL:', process.env.VERCEL);
      console.log('[ENV] VERCEL_REGION:', process.env.VERCEL_REGION);
      console.log('[ENV] Node Version:', process.version);
      console.log('[MEM] Initial:', JSON.stringify(process.memoryUsage()));
      
      try {
        const toolDir = require('../src/utils/nc-config/helpers').getToolDir();
        console.log('[CONFIG] Tool Dir:', toolDir);
      } catch (e) {
        console.error('[CONFIG] Failed to get tool dir:', e.message);
      }
      
      const dbUrl = process.env.NC_DB || process.env.DATABASE_URL;
      if (dbUrl) {
        const safeUrl = dbUrl.replace(/:[^:@]+@/, ':****@');
        console.log('[DB] Database URL provided:', safeUrl);
      } else {
        console.warn('[DB] NC_DB not provided, will use SQLite in /tmp');
      }

      const dummyServer: any = {
        on: () => {},
        address: () => ({ port: process.env.PORT || 8080 }),
      };
      
      console.log('[INIT] Creating Noco instance...');
      console.time('[INIT] Noco.init');
      
      const result = await Promise.race([
        Noco.init({}, dummyServer, app),
        new Promise((_, reject) => 
          setTimeout(() => reject(new Error('Noco.init timeout after 55s')), 55000)
        )
      ]);
      
      console.timeEnd('[INIT] Noco.init');
      nocoApp = result;
      app.use(nocoApp);
      console.log('[INIT] NocoDB initialized successfully');
      console.log('[MEM] Final:', JSON.stringify(process.memoryUsage()));
      return nocoApp;
    } catch (error) {
      console.error('[ERROR] NocoDB Initialization Failed:', error.message);
      console.error('[ERROR] Stack:', error.stack);
      initError = error;
      initializationPromise = null; // Allow retry on next request
      throw error;
    }
  })();

  return initializationPromise;
}

export default async (req: express.Request, res: express.Response) => {
  console.log('[REQUEST] Incoming:', req.method, req.url);
  console.log('[REQUEST] Headers:', JSON.stringify(req.headers));
  
  try {
    console.log('[HANDLER] Calling initNoco...');
    await initNoco();
    console.log('[HANDLER] initNoco completed, forwarding request');
    return app(req, res);
  } catch (error) {
    console.error('[HANDLER] Request handler error:', error.message);
    console.error('[HANDLER] Stack:', error.stack);
    
    if (!res.headersSent) {
      res.status(500).json({
        error: 'Failed to initialize NocoDB',
        message: error.message,
        details: initError ? {
          initError: initError.message,
          initStack: initError.stack
        } : undefined,
        stack: process.env.NODE_ENV === 'development' ? error.stack : undefined
      });
    }
  }
};

import dns from 'node:dns';
import express from 'express';
import cors from 'cors';
import Noco from '../src/Noco';

dns.setDefaultResultOrder('ipv4first');

process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});

const app = express();
app.enable('trust proxy');
app.use(cors());
app.set('view engine', 'ejs');

let nocoApp: any = null;
let initializationPromise: Promise<any> | null = null;

async function initNoco() {
  if (nocoApp) return nocoApp;
  if (initializationPromise) return initializationPromise;

  initializationPromise = (async () => {
    try {
      console.log('Initializing NocoDB...');
      console.log('Environment:', process.env.NODE_ENV);
      console.log('Vercel Region:', process.env.VERCEL_REGION);
      console.log('Node Version:', process.version);
      console.log('Memory Usage (Initial):', JSON.stringify(process.memoryUsage()));
      console.log('Tool Dir:', require('../src/utils/nc-config/helpers').getToolDir());
      
      const dbUrl = process.env.NC_DB || process.env.DATABASE_URL;
      if (dbUrl) {
        console.log('Database URL is provided (obfuscated):', dbUrl.replace(/:[^:@]+@/, ':****@'));
      } else {
        console.warn('NC_DB is not provided, defaulting to SQLite in /tmp');
      }

      const dummyServer: any = {
        on: () => {},
        address: () => ({ port: process.env.PORT || 8080 }),
      };
      
      console.log('Calling Noco.init...');
      console.time('Noco.init');
      const result = await Noco.init({}, dummyServer, app);
      console.timeEnd('Noco.init');
      nocoApp = result;
      app.use(nocoApp);
      console.log('NocoDB Initialized successfully');
      console.log('Memory Usage (Final):', JSON.stringify(process.memoryUsage()));
      return nocoApp;
    } catch (error) {
      console.error('NocoDB Initialization Error:', error);
      if (error.stack) console.error(error.stack);
      initializationPromise = null; // Allow retry on next request
      throw error;
    }
  })();

  return initializationPromise;
}

export default async (req: express.Request, res: express.Response) => {
  try {
    await initNoco();
    return app(req, res);
  } catch (error) {
    console.error('Vercel API Error:', error);
    if (!res.headersSent) {
      res.status(500).json({
        message: 'Failed to initialize NocoDB',
        error: error.message,
        stack: process.env.NODE_ENV === 'development' ? error.stack : undefined
      });
    }
  }
};

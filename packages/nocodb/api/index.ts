import dns from 'node:dns';
import express from 'express';
import cors from 'cors';
import Noco from '../src/Noco';

dns.setDefaultResultOrder('ipv4first');

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
      const dummyServer: any = {
        on: () => {},
        address: () => ({ port: process.env.PORT || 8080 }),
      };
      const result = await Noco.init({}, dummyServer, app);
      nocoApp = result;
      app.use(nocoApp);
      console.log('NocoDB Initialized successfully');
      return nocoApp;
    } catch (error) {
      console.error('NocoDB Initialization Error:', error);
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

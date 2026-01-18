import dns from 'node:dns';
import express from 'express';
import cors from 'cors';
import Noco from '../src/Noco';
import { handleUncaughtErrors } from '../src/utils';

handleUncaughtErrors(process);
dns.setDefaultResultOrder('ipv4first');

const app = express();
app.enable('trust proxy');
app.use(cors());
app.set('view engine', 'ejs');

let nocoApp: any = null;

export default async (req: express.Request, res: express.Response) => {
  if (!nocoApp) {
    // Pass a dummy server instance for initialization if needed, 
    // though Noco.init normally takes a real one.
    // For Vercel, we just need the express app to be populated with Noco routes.
    const dummyServer: any = {
      on: () => {},
      address: () => ({ port: process.env.PORT || 8080 }),
    };
    nocoApp = await Noco.init({}, dummyServer, app);
    app.use(nocoApp);
  }
  
  return app(req, res);
};

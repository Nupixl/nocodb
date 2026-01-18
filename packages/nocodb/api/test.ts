import type { VercelRequest, VercelResponse } from '@vercel/node';

export default function handler(req: VercelRequest, res: VercelResponse) {
  console.log('[TEST] Test endpoint called');
  console.log('[TEST] Method:', req.method);
  console.log('[TEST] URL:', req.url);
  
  return res.status(200).json({
    status: 'ok',
    message: 'Vercel serverless function is working',
    timestamp: new Date().toISOString(),
    env: {
      NODE_VERSION: process.version,
      PLATFORM: process.platform,
      VERCEL: process.env.VERCEL,
      VERCEL_REGION: process.env.VERCEL_REGION,
    }
  });
}

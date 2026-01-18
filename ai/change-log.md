# Change Log

- 2026-01-17: Rebranded project to Social Pixl across package.json, README, and governance files.
- 2026-01-17: Adjusted `engines` in `package.json` to `>=22.12.0` and set `engine-strict=false` in `.npmrc` to fix Vercel environment mismatch (Vercel uses Node v24).
- 2026-01-17: Fixed Vercel deployment error by removing `use-node-version` from `.npmrc` and adding `engines` to root `package.json`.
- 2026-01-17: Bootstrapped .cursor/rules and ai/ governance directories. Created initial project profile.
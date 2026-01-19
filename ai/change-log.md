# Change Log

- 2026-01-19: Created 10 views including Kanban boards for Tasks (by Status and Ralph Status) and Features (by Status). Added 34 essential fields across all tables for complete project management: time tracking, MCP planning, assignments, checklist progress, and protocol metrics. Platform now production-ready with visual workflow management.
- 2026-01-19: Successfully implemented Social Pixl schema via NocoDB API. Created Features and Protocol Sessions tables, enhanced Projects and Tasks tables with 15+ new fields. Populated with sample data. Railway-hosted instance now ready for protocol system integration.
- 2026-01-18: Created comprehensive Social Pixl (NocoDB) project management schema with 9 tables supporting Ralph Protocol and full agent workflow tracking. Includes implementation guide, quick start template, and master documentation index.
- 2026-01-18: Designed modular agent protocol system with user-invoked protocols (Ralph, Test, Security, Deploy, Debug, Audit). Each protocol is self-contained with flexible MCP associations.
- 2026-01-18: Documented Ralph Protocol with checklist-driven task execution, automatic retry logic, human checkpoints, and real-time Social Pixl logging.
- 2026-01-17: Rebranded project to Social Pixl across package.json, README, and governance files.
- 2026-01-17: Adjusted `engines` in `package.json` to `>=22.12.0` and set `engine-strict=false` in `.npmrc` to fix Vercel environment mismatch (Vercel uses Node v24).
- 2026-01-17: Fixed Vercel deployment error by removing `use-node-version` from `.npmrc` and adding `engines` to root `package.json`.
- 2026-01-17: Bootstrapped .cursor/rules and ai/ governance directories. Created initial project profile.
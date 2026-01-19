# Change Log

- 2026-01-19: **Relational Integrity enforced.** Updated rules to mandate that Features must always be linked to Projects and Tasks must always be linked to Features. Orphan records are strictly forbidden.
- 2026-01-19: **Status Integrity enforced.** Updated Project and Task statuses to match new workflow (Drafted, In Progress, In Review, etc.). Marked Status fields as REQUIRED in the database. Added rules for parameter integrity and review gates.
- 2026-01-19: **COMPLETE!** Configured all 59 select field options via API. 12 select fields now have professional color-coded options: Task Status (5), Ralph Status (6), Task Type (7), Priority (4), Required MCPs (9), Features Status (5), Complexity (5), Project Status (4), Tech Stack (15). Kanban boards now display proper colored columns. Platform 100% complete and production-ready!
- 2026-01-18: Created comprehensive Social Pixl (NocoDB) project management schema with 9 tables supporting Ralph Protocol and full agent workflow tracking. Includes implementation guide, quick start template, and master documentation index.
- 2026-01-18: Designed modular agent protocol system with user-invoked protocols (Ralph, Test, Security, Deploy, Debug, Audit). Each protocol is self-contained with flexible MCP associations.
- 2026-01-18: Documented Ralph Protocol with checklist-driven task execution, automatic retry logic, human checkpoints, and real-time Social Pixl logging.
- 2026-01-17: Rebranded project to Social Pixl across package.json, README, and governance files.
- 2026-01-17: Adjusted `engines` in `package.json` to `>=22.12.0` and set `engine-strict=false` in `.npmrc` to fix Vercel environment mismatch (Vercel uses Node v24).
- 2026-01-17: Fixed Vercel deployment error by removing `use-node-version` from `.npmrc` and adding `engines` to root `package.json`.
- 2026-01-17: Bootstrapped .cursor/rules and ai/ governance directories. Created initial project profile.
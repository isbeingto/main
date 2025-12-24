# OSS Baseline Adoption

Baseline: https://github.com/namanh11611/flutter_mvvm_riverpod
License: MIT (see upstream LICENSE)

## Selection Rationale

- MVVM + Riverpod + go_router matches the requested architecture.
- Supabase is already wired in main initialization.
- Includes localization, theming, and common UI scaffolding for a production-grade starter.

## Merge Strategy (Recorded)

1) Use the OSS baseline for `lib/`, `assets/`, `pubspec.yaml`, and `analysis_options.yaml`.
2) Preserve this repo's `supabase/` directory (config.toml, migrations) and local env files.
3) Keep `.env` out of version control; track `.env.example` only.
4) Resolve conflicts in favor of "compiles, runs, and stays structurally clear".

## Changes Applied

- Copied OSS `lib/` and `assets/` structure into the repo.
- Updated `pubspec.yaml` to baseline dependencies and build tools.
- Updated `.gitignore` to protect secrets and generated files.
- Updated `.env.example` with the full set of baseline keys.
- Refreshed README with quickstart, env setup, and environment switching.

## Differences vs Upstream

- Project name is `farm_app` and version is `0.1.0+1`.
- `supabase/` directory stays from this repo (linked project config retained).
- README is tailored for this repo's setup and workflows.
- No secrets are committed; `.env` remains local only.

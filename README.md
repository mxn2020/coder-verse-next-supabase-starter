# Next.js Supabase Starter Template

Full-stack template with Next.js, Supabase, NextAuth, Upstash Redis, and QStash.

## Features
- Authentication with NextAuth 
- Supabase Database
- Redis Caching
- Background Jobs with QStash
- Protected Routes
- Landing Page

## Template Usage
1. Use template to create new repository on GitHub
2. Clone new repository
3. Add template as upstream:
```bash
git remote add template https://github.com/mxn2020/next-supabase-template.git
```
4. Pull template updates when needed:
```bash
# Create branches for managing updates
git checkout -b template-updates  # For reviewing template changes
git checkout -b custom-features   # For your customizations

# Get template updates
git checkout template-updates
git fetch template
git merge template/main

# Selectively merge updates
git checkout custom-features
git cherry-pick <commit-hash>   # For specific updates
# OR
git checkout template-updates -- path/to/file  # For specific files
```

## Rinse and Repeat

Each time the original template repository releases updates:

```bash
# Create branches for managing updates
git checkout template-updates
git fetch template
git merge template/main

# Review changes on template-updates.
git checkout custom-features (or main)
git merge template-updates (or cherry-pick specific commits)
```

This way, your custom project always stays up to date with the latest features and fixes from the template, while preserving all of your own code.

## Setup
1. Clone repository 
2. Copy .env.example to .env
3. Configure environment variables
4. Run:
```bash
pnpm install
pnpm dev
```

## Deployment
Deploy to Vercel:
```bash
vercel
```

## Environment Variables
See `.env.local.example` for required variables

---

> **License note:** As of 2026-10-23 this project is licensed under the Apache License 2.0 (previously MIT). Versions released before this change remain available under MIT to those who received them.

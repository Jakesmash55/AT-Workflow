# AT-Workflow

This repository contains the MotionInsight AI planning documents and GitHub-based validation checks.

## Run tests locally

```bash
bash scripts/test_docs.sh
```

## GitHub testing

A GitHub Actions workflow runs on push and pull requests:

- `.github/workflows/ci.yml`
- Executes `scripts/test_docs.sh`
- Fails the build if critical blueprint/testing sections or required safety language are missing

This makes documentation changes testable and reviewable in GitHub before merge.

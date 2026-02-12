#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "[FAIL] $1" >&2
  exit 1
}

pass() {
  echo "[PASS] $1"
}

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

required_files=(
  "APP_BLUEPRINT.md"
  "TESTING_GUIDE.md"
)

for file in "${required_files[@]}"; do
  [[ -f "$file" ]] || fail "Missing required file: $file"
  [[ -s "$file" ]] || fail "File is empty: $file"
  pass "Required file exists and is non-empty: $file"
done

# Validate critical product sections exist in APP_BLUEPRINT.md
blueprint_sections=(
  "## 1) Product Vision"
  "## 4) MVP Scope (Phase 1)"
  "## 5) Full-Body Biomechanical Breakdown"
  "## 7) Explicit User Instructions for Accurate Analysis"
  "## 10) Clinical Safety, Legal, and Ethical Framework"
  "## 13) Accuracy Strategy (Critical Requirement)"
  "## 19) Next-Step Execution Plan (First 6 Weeks)"
)

for section in "${blueprint_sections[@]}"; do
  rg -Fq "$section" APP_BLUEPRINT.md || fail "APP_BLUEPRINT.md missing section: $section"
  pass "Blueprint section found: $section"
done

# Validate critical testing sections exist in TESTING_GUIDE.md
testing_sections=(
  "## 2) Test Strategy Overview"
  "## 4.3 Joint-Angle Accuracy Tests (Critical)"
  "## 4.7 Safety and Legal Compliance Tests"
  "## 5) Pilot Test Protocol (First Real Deployment)"
  "## 6) QA Checklist for Each Release"
  "## 9) Traceability Matrix (Requirement -> Test)"
)

for section in "${testing_sections[@]}"; do
  rg -Fq "$section" TESTING_GUIDE.md || fail "TESTING_GUIDE.md missing section: $section"
  pass "Testing section found: $section"
done

# Ensure disclaimer language is present in product blueprint
rg -Fq "educational and informational tool only" APP_BLUEPRINT.md || fail "Disclaimer text missing from APP_BLUEPRINT.md"
pass "Disclaimer language is present"

# Ensure measurable acceptance criteria are documented in testing guide
rg -Fq "MAE" TESTING_GUIDE.md || fail "MAE metric missing from TESTING_GUIDE.md"
rg -Fq "ICC" TESTING_GUIDE.md || fail "ICC metric missing from TESTING_GUIDE.md"
rg -Fq "100% pass for safety/legal checks" TESTING_GUIDE.md || fail "Safety/legal acceptance criterion missing"
pass "Measurable acceptance criteria are present"

echo "All documentation checks passed."

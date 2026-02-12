# MotionInsight AI — How to Test the App

This guide explains how to test MotionInsight AI from prototype to pilot with a strong focus on **joint-angle accuracy**, **risk-output reliability**, and **safe exercise recommendations**.

## 1) What You Can Test Right Now (Given Current Blueprint Stage)
Because the project currently has product/design documentation (not production code yet), start with a **test protocol** that validates requirements before implementation.

Immediate testable outputs:
- Assessment workflows and user instructions
- Metric definitions and acceptance thresholds
- Risk-output explainability rules
- Home Exercise Program (HEP) progression logic
- Safety and legal guardrails

Use this guide as your QA baseline when building the first app version.

---

## 2) Test Strategy Overview
Run testing in 5 layers:

1. **Clinical Requirement Validation**
   - Verify every required metric and movement task is implemented as specified.
2. **Capture Quality Validation**
   - Ensure camera setup checks reliably block low-quality recordings.
3. **Biomechanical Accuracy Validation**
   - Compare computed angles against reference systems or expert labels.
4. **Risk and Recommendation Validation**
   - Validate risk flags, confidence scores, and corrective plans are consistent/explainable.
5. **Usability + Safety Validation**
   - Confirm users can complete flows quickly and safely with clear disclaimers.

---

## 3) Test Environments You Should Prepare
## A. Technical Environments
- iOS devices: at least 2 generations (e.g., older + current)
- Android devices: at least 2 tiers (mid-range + flagship)
- Lighting scenarios: bright indoor, dim indoor, mixed lighting
- Clothing scenarios: fitted, loose, high-contrast, low-contrast
- Camera distance scenarios: in-range and out-of-range

## B. Human Diversity Coverage
Build a test panel spanning:
- Different body sizes/heights
- Different skin tones
- Different movement skill levels
- Healthy + known movement limitations (with appropriate oversight)

This is important for fairness and model robustness.

---

## 4) Detailed Test Plan
## 4.1 Functional Tests (Product Behavior)
### Goal
Confirm the app works as intended for core flows.

### Must-pass checks
- User can complete onboarding and accept Terms/Disclaimer.
- User can select a quick screen vs full-body battery.
- User receives explicit setup and movement instructions before recording.
- App blocks processing when quality is below threshold.
- App produces results dashboard with metrics, confidence, risk level, and exercises.
- User can save session and review trend history.

### Acceptance
- >= 95% completion rate for happy-path flow without crashes in internal QA.

---

## 4.2 Capture Quality Gate Tests
### Goal
Ensure poor video quality is detected before analysis.

### Test cases
- Backlit subject
- Subject partly out of frame
- Occluded joints (object/person blocking)
- Very loose clothing
- Camera too close / too far
- Too low frame rate

### Expected behavior
- App returns specific corrective prompts (not vague errors).
- App prevents low-confidence analysis from being shown as definitive.

### Acceptance
- >= 90% of intentionally bad captures are correctly rejected.

---

## 4.3 Joint-Angle Accuracy Tests (Critical)
### Goal
Quantify angle error and repeatability.

### Method
1. Select movement battery (squat, lunge, single-leg squat, gait).
2. Record each participant simultaneously with:
   - App camera setup
   - Reference standard (ideal: lab 3D motion capture; fallback: expert video goniometry protocol)
3. Time-align trials.
4. Compare key angles frame-by-frame or event-by-event (peak knee flexion, trunk lean, etc.).
5. Compute:
   - MAE (mean absolute error)
   - RMSE
   - ICC (test-retest reliability)
   - Bias by subgroup (lighting, clothing, body type)

### Suggested targets
- Sagittal knee flexion MAE <= 5-7 degrees (controlled conditions)
- Repeatability ICC >= 0.80 for priority metrics
- No subgroup with materially worse performance without explicit confidence downgrades

---

## 4.4 Risk Classification and Explainability Tests
### Goal
Validate risk outputs are stable and interpretable.

### Method
- Create clinician-labeled reference dataset (low/mod/high risk cases).
- Compare app risk outputs vs panel consensus.
- Confirm each risk output includes top factors (e.g., valgus proxy + trunk shift).
- Confirm confidence score behavior:
  - High confidence in clear captures
  - Lower confidence when occlusion/quality degrades

### Metrics
- Agreement rate / weighted kappa with clinician panel
- Calibration (confidence vs correctness)
- False-high-risk and false-low-risk rates

---

## 4.5 HEP Recommendation and Progression Tests
### Goal
Ensure exercise plans are safe, relevant, and progressive.

### Test cases
- Different goals: pain reduction, return-to-sport, performance
- Different equipment availability
- Different weekly training frequencies
- Symptom worsening during week 1 follow-up

### Expected behavior
- Plan includes warm-up, corrective block, strength block, cool-down.
- Progression only occurs if movement quality + tolerance criteria are met.
- Regression occurs when pain/exertion thresholds are exceeded.

---

## 4.6 Usability Tests
### Goal
Verify that clinicians and individuals can use it quickly.

### Method
- Conduct moderated usability sessions (10-15 clinicians, 10-15 non-clinicians).
- Measure:
  - Time to complete first assessment
  - Instruction clarity
  - Perceived trust in results
  - Ability to understand recommended exercises

### Acceptance targets
- Median time-to-result < 3 minutes for quick screen
- System Usability Scale (SUS) >= 80 target
- >= 85% users correctly interpret top-line risk summary

---

## 4.7 Safety and Legal Compliance Tests
### Goal
Confirm user protection and disclaimer visibility.

### Checks
- Disclaimer shown and acknowledged at onboarding.
- Disclaimer included in exported reports.
- Red-flag symptom input triggers escalation guidance.
- No wording implies diagnosis/treatment by app itself.

### Acceptance
- 100% pass for safety/legal checks before pilot.

---

## 5) Pilot Test Protocol (First Real Deployment)
Use a small pilot before scaling.

## Recommended pilot
- 2-4 clinics
- 50-150 users total
- 4-8 week observation period

## Pilot outcomes to track
- Assessment completion rate
- Re-test adherence
- Clinician trust score
- Change in movement-risk indicators over time
- Reported adverse events

Pause scaling if:
- High disagreement with clinician consensus
- Unacceptable subgroup bias
- Elevated adverse-event signals

---

## 6) QA Checklist for Each Release
Before each release, run a release gate:

- [ ] Functional regression tests pass
- [ ] Capture quality rejection tests pass
- [ ] Accuracy benchmarks not degraded
- [ ] Risk-model calibration unchanged or improved
- [ ] HEP safety rules pass scenario tests
- [ ] Disclaimer and legal text validated
- [ ] Analytics/audit logging verified
- [ ] Rollback plan documented

---

## 7) Practical “Start This Week” Testing Plan
If you want immediate momentum:

Day 1-2:
- Finalize metric dictionary and angle definitions.
- Build 20 scripted test scenarios (good + bad captures).

Day 3-4:
- Run internal capture tests across 4-6 phones.
- Validate quality gates and error prompts.

Day 5:
- Conduct 5 clinician walkthroughs and 5 individual-user walkthroughs.
- Capture usability friction points.

Day 6-7:
- Revise UX copy and capture guidance.
- Freeze acceptance criteria for MVP pilot.

---

## 8) Suggested Tooling for Test Operations
- Test management: Linear/Jira + test case templates
- Analytics: event tracking for every step in assessment flow
- Model validation notebooks: MAE/RMSE/ICC + subgroup fairness dashboards
- Error monitoring: Crashlytics/Sentry
- Experiment tracking: version every model/rule update with changelog

---

## 9) Traceability Matrix (Requirement -> Test)
Use this minimal mapping in QA docs:

- **Joint angle accuracy** -> Reference-comparison study + MAE/RMSE/ICC metrics
- **Imbalance detection** -> Asymmetry test suite + clinician agreement
- **Injury risk overview** -> Risk classification calibration + explainability checks
- **Corrective exercises** -> Scenario-based progression/regression tests
- **Educational-only legal posture** -> Disclaimer placement + wording audit
- **User-friendliness** -> Time-to-result + SUS + interpretation checks

This ensures every product promise is objectively tested before broad release.

# Completion gate

Do not claim the project or milestone is complete until every applicable condition passes.

## Required checks

- [ ] Every enabled document is internally complete and consistent with the implemented behavior.
- [ ] Every acceptance criterion in `PRD.md` is satisfied or explicitly deferred by the user.
- [ ] Primary flows, critical failure states, and recovery paths are verified.
- [ ] Relevant tests, static checks, builds, and package validation pass.
- [ ] Required manual, visual, accessibility, integration, migration, deployment, or rollback checks pass.
- [ ] No unexplained high-risk issue remains.
- [ ] Temporary debugging code, generated test debris, and unused artifacts are removed.
- [ ] `IMPLEMENTATION_PLAN.md` reflects actual completion and remaining work.
- [ ] `progress.txt` contains an accurate final or handoff state and the latest verification evidence.
- [ ] Durable instructions and confirmed lessons are updated without duplicating executable truth.
- [ ] A user can follow the repository instructions to run or use the result.

## Final report

Report:

1. What was delivered.
2. Which acceptance criteria were verified.
3. Commands and checks run, with results.
4. Any limitations, deferred work, or environment-dependent verification.
5. The next action only when meaningful.

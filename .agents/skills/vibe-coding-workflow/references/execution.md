# Document generation and execution

## Generation order

Generate and confirm documents in this order:

1. `PRD.md`
2. `APP_FLOW.md`
3. `TECH_STACK.md`
4. `FRONTEND_GUIDELINES.md`
5. `BACKEND_STRUCTURE.md`
6. `IMPLEMENTATION_PLAN.md`
7. `AGENTS.md`
8. `progress.txt`
9. `lessons.md`

An enabled downstream document must not contradict an enabled upstream document. Return to interrogation when a newly discovered decision changes the product scope or acceptance criteria.

## Source-of-truth boundaries

| Information | Authority |
|---|---|
| Product goals, scope, non-goals, acceptance | `PRD.md` |
| User journeys and states | `APP_FLOW.md` |
| Technology decisions and restrictions | `TECH_STACK.md` |
| Visual and interaction rules | `FRONTEND_GUIDELINES.md` plus implemented design tokens |
| Backend boundaries and rationale | `BACKEND_STRUCTURE.md` |
| Exact dependency versions | Package manifest and lockfile |
| Exact database structure | Schema and migration files |
| Exact API contract | OpenAPI, schema, or shared types |
| Work order and acceptance checks | `IMPLEMENTATION_PLAN.md` |
| Durable agent behavior | `AGENTS.md` |
| Current handoff state | `progress.txt` |
| Confirmed reusable failure patterns | `lessons.md` |

## Implementation plan quality

Each plan item must have:

- A concrete deliverable.
- Dependencies or prerequisites.
- A bounded change surface.
- Observable acceptance criteria.
- A named verification method.

Prefer vertical slices that deliver a complete user-visible behavior through interface, logic, data, and tests. Keep only one item `IN PROGRESS` unless parallel work was explicitly authorized.

## Execution loop

For each plan item:

1. Read the applicable enabled documents and current `progress.txt`.
2. State the bounded outcome and verification method.
3. Implement the smallest coherent slice.
4. Run the relevant automated checks.
5. Perform manual, visual, integration, migration, or recovery checks when behavior requires them.
6. Compare results with the plan item's acceptance criteria.
7. Fix failures and rerun the affected checks.
8. Update `IMPLEMENTATION_PLAN.md` and `progress.txt` only after verification.
9. Record a lesson only if the lesson gate below is satisfied.

## Progress update points

Update `progress.txt`:

- After a verified plan item finishes.
- When current work, next work, a blocker, or a known bug changes.
- Before ending or handing off a session.
- After the verification baseline changes.

## Lesson gate

Before writing `lessons.md`, ask in order:

1. Can a regression test prevent recurrence? Add the test.
2. Can a type, linter, schema, or automation prevent recurrence? Add it.
3. Is it a stable project rule? Update `AGENTS.md`.
4. Is it a confirmed, reusable, non-obvious failure pattern that remains relevant? Enable and update `lessons.md`.
5. Otherwise, do not persist it.

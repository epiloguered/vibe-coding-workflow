# Requirement interrogation

## Objective

Reach at least 95% practical confidence that the intended product, scope, constraints, and completion conditions are understood before generating specifications or application code. Treat 95% as a readiness heuristic; the objective gate below is mandatory.

## Method

1. Summarize the current understanding in concise language.
2. Identify the single unanswered question with the highest impact on product behavior, architecture, security, cost, or acceptance.
3. Ask only that question.
4. Use the answer to update the working understanding and ask the next highest-value question.
5. State assumptions explicitly. A user may approve an assumption instead of providing more detail.
6. Stop when every gate item is answered or explicitly accepted and no unresolved answer could materially change the plan.

Do not ask about information that can be discovered safely from supplied files, an existing repository, or the local environment. Do not ask implementation trivia that Codex can decide safely and reverse cheaply.

## Question priority

Ask in this order when relevant:

1. Problem, target user, and desired outcome.
2. In-scope and out-of-scope behavior.
3. Primary user journey and critical error or recovery paths.
4. Data ownership, persistence, privacy, authentication, and authorization.
5. Target platforms, integrations, deployment, and operational constraints.
6. Visual direction, accessibility, responsiveness, and supported devices.
7. Measurable acceptance criteria.
8. Schedule, migration, compatibility, or budget constraints.

## Readiness gate

All applicable items must be clear or explicitly accepted:

- [ ] The problem and intended outcome are clear.
- [ ] The target user and primary scenario are clear.
- [ ] Scope and explicit non-goals are clear.
- [ ] The main flow and critical failure states are clear.
- [ ] Data, authentication, permissions, and external dependencies are clear.
- [ ] Platform, deployment, and important technical constraints are clear.
- [ ] Visual and interaction expectations are clear when a user interface exists.
- [ ] Acceptance criteria are observable and testable.
- [ ] No unresolved decision can materially change product scope, architecture, security, data, cost, or acceptance.

## Exit output

Before document generation, provide:

1. A short project understanding.
2. Confirmed decisions.
3. Explicit assumptions.
4. Open non-blocking questions, if any.
5. The document activation table required by `document-rules.md`.

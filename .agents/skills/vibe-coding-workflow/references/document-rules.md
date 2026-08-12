# Fixed document activation rules

## Universal control block

Create all nine documents. Each document must begin with control data containing:

- `Status`: `ENABLED` or `DISABLED`.
- `Enable reason`: why it is active, or `N/A`.
- `Disable reason`: why it is inactive, or `N/A`.
- `Re-evaluate when`: the event that requires status review.
- `Last updated`: an ISO date (`YYYY-MM-DD`).

For a disabled document, do not fill its normal specification sections with guessed content.

## Activation matrix

| Document | Enable when | Disable when |
|---|---|---|
| `PRD.md` | Creating a new product, project, or feature whose goals, users, scope, non-goals, stories, or success criteria must be defined. | A separately supplied PRD is explicitly authoritative and already covers the work, or the task is a purely mechanical change with no product decision. For a new project, default to enabled. |
| `APP_FLOW.md` | The product has screens, routes, user actions, branches, roles, state transitions, success states, failure states, or recovery paths. | The deliverable has no user flow, or consists of one unambiguous step with no meaningful state transition. |
| `TECH_STACK.md` | Starting a new project, selecting or restricting technologies, introducing important dependencies, or defining runtime and deployment environments. | An established project's stack is fully authoritative in code and configuration and the work changes no technical component. For a new project, default to enabled. |
| `FRONTEND_GUIDELINES.md` | The project has a user interface requiring visual consistency, responsive behavior, components, typography, spacing, accessibility, or interaction rules. | The project is backend-only, CLI-only, data-only, or otherwise has no graphical user interface. |
| `BACKEND_STRUCTURE.md` | The project has server logic, APIs, databases, authentication, authorization, storage, background jobs, third-party services, or sensitive data. | The project is static or entirely local and has no server-side behavior or persistent data structure needing specification. |
| `IMPLEMENTATION_PLAN.md` | Work spans multiple steps, modules, dependencies, milestones, sessions, migrations, or verification stages. | A single, obvious, reversible modification can be completed and verified in one operation. For a new project, default to enabled. |
| `AGENTS.md` | The repository needs durable commands, project conventions, prohibited actions, document routing, or verification rules. | Only for an explicitly disposable experiment with no durable rule. For repositories created by this workflow, default to enabled. |
| `progress.txt` | Work crosses sessions, days, milestones, machines, or agents; or contains multiple active tasks, blockers, or known bugs. | Everything will be completed in one uninterrupted session and no handoff state is useful. |
| `lessons.md` | At least one confirmed, reusable failure pattern exists that cannot yet be prevented more reliably by code, tests, types, linting, or automation. | No reusable lesson exists yet. Default to disabled at project creation. |

## Required confirmation table

Present this table before creating files:

| Document | Status | Reason | Re-evaluate when |
|---|---|---|---|
| `PRD.md` | `ENABLED` or `DISABLED` | Project-specific reason | Concrete trigger |

Include all nine rows. Wait for confirmation when a status or assumption could materially affect the project.

## Status transitions

- Change `DISABLED` to `ENABLED` when its re-evaluation trigger occurs.
- Change `ENABLED` to `DISABLED` only when the governed capability is removed, an explicitly named authoritative source replaces it, or the user confirms retirement.
- Preserve the file and update the reason and date. Do not delete history merely because a document becomes disabled.

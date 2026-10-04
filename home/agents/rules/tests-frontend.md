
- NEVER test visual details: colors, classes, spacing, icons, static copy. Changing a button from red to orange gets no test.

- NEVER test that the framework does its job: a `v-model` writing to state, a prop reaching the template, a static list rendering.

- When a state is shown visually, assert it through what assistive tech sees, never through classes. If the component exposes no such attribute, add the semantic one it is missing. For example:
  - invalid input — `aria-invalid="true"`, not `bg-destructive`
  - current item — `aria-current`, not a highlight class
  - toggled button — `aria-pressed`, not an active class
  - anything else — role and accessible name

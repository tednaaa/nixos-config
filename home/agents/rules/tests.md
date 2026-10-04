- Test behaviour a user or caller relies on: calculations, parsing, branching logic, flows. A test exists because a real bug could hide there.

- NEVER test what the code already guarantees by itself: a valibot/zod schema shape, types, a library or the language doing its own job, a constant equal to its value, a function that only copies fields.

- NEVER add a test that goes through the same branch with the same kind of input as an existing one.

- Fix bugs with TDD: first write a test that reproduces the bug and fails, then fix the code until it passes.

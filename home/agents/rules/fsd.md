For cross-slice imports in FSD code, import from the slice's public `index.ts` entry point. Use `@/entities/indicator`, never `@/entities/indicator/indicators` or another internal path. Within a slice, relative imports to its own files are allowed. Page-local imports do not need public entry points.

A slice's or component group's `index.ts` is its only re-export point. Implementation files (`variants.ts`, `.vue` SFCs, `types.ts`) export their own declarations and never re-export from a sibling.

FSD is followed loosely. Don't refactor working code only to satisfy layer direction, even when a plan lists it; the public entry point rule above still holds.

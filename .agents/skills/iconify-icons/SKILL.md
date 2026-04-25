---
name: iconify-icons
description: Use this skill when choosing, installing, or implementing Iconify icons in frontend projects, including React, Next.js, plain HTML, Web Components, Tailwind CSS 3/4, CSS masks/backgrounds, offline icon data, custom icon sets, icon naming, sizing, color, and performance tradeoffs.
---

# Iconify Icons

## Core Workflow

1. Inspect the project stack before choosing an integration: framework, SSR mode, Tailwind version, bundler, package manager, and existing icon conventions.
2. Prefer the project's existing icon system if one is already established; use Iconify only when it is requested or clearly fits the codebase.
3. Choose the narrowest Iconify integration that solves the task:
   - React client-only UI: `@iconify/react`.
   - Next.js or SSR-sensitive UI: `iconify-icon` Web Component, Tailwind plugin, Unplugin Icons, or bundled icon data.
   - Tailwind utility icons: `@iconify/tailwind4` for Tailwind 4, `@iconify/tailwind` for Tailwind 3.
   - CSS-only usage: Iconify API URLs or generated CSS with masks/background images.
   - No runtime API dependency: install `@iconify-json/{prefix}` packages or pass icon data directly.
4. Use official icon names in `prefix:name` form, for example `mdi:home`, `lucide:search`, `solar:settings-bold`, or `vscode-icons:file-type-tailwind`.
5. Verify the icon renders in the target environment and that color, size, alignment, and accessibility match the surrounding UI.

## Implementation Rules

- Avoid shipping huge icon packages when only one or two icon sets are needed. Prefer `@iconify-json/{prefix}` over `@iconify/json` for app bundles and CI speed.
- Do not assume monotone icons can behave like palette icons. Monotone icons can follow `currentColor`; palette icons usually keep their built-in colors.
- Use `font-size`, `width`, `height`, or framework-specific size props deliberately. Iconify defaults commonly behave like text at `1em`.
- Style monotone icons with `color: currentColor` or parent text color when possible. Set explicit `color`, Tailwind `text-*`, CSS variables, or component `color` props only when the icon needs to differ from surrounding text.
- Control size with one consistent mechanism per usage: React `width`/`height`, Web Component `width`/`height`, CSS `font-size`, or Tailwind `size-*`/`w-* h-*`. Avoid mixing several size controls on the same icon.
- Align inline icons with text using `vertical-align`, `line-height`, `inline-flex`, or wrapper flex alignment instead of trial-and-error margins.
- Treat stroke width and filled style as icon-set choices. Iconify does not reliably normalize stroke width across sets; choose an icon set whose visual weight matches the UI.
- Add accessible labels only when the icon conveys meaning. Decorative icons should be hidden from assistive tech when the local UI pattern supports it.
- Keep icon set choices visually coherent within one feature. Mixing many sets in one toolbar usually looks accidental.
- For dynamic Tailwind class names, make sure class strings are statically discoverable or safelisted according to the project's Tailwind setup.
- In Next.js server components, do not drop `@iconify/react` directly into server-rendered markup unless the project already handles the client-only behavior.

## Reference Loading

Read [references/iconify-implementation.md](references/iconify-implementation.md) when you need concrete install commands, code snippets, Tailwind setup, Web Component setup, color/size/alignment styling, CSS masks/backgrounds, offline usage, or official documentation links.

## Output Expectations

When applying this skill to a codebase:

1. State which Iconify integration you selected and why.
2. Modify the smallest set of files needed.
3. Add package dependencies using the repo's package manager.
4. Preserve existing styling and component patterns.
5. Run the relevant formatter, typecheck, build, or visual smoke test when feasible.

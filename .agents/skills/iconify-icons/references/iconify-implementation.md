# Iconify Implementation Reference

Official docs: https://iconify.design/docs/

Use this reference for concrete Iconify setup patterns. Prefer the newest official docs when a project is using a newer framework or Tailwind version than these examples cover.

## Icon Names

Icon names normally use:

```text
prefix:name
```

Examples:

```text
mdi:home
mdi-light:home
lucide:search
vscode-icons:file-type-tailwind
fluent-emoji-flat:alarm-clock
```

For Tailwind icon selectors, replace the colon with `--` inside the class:

```html
<span class="icon-[mdi-light--home]"></span>
```

Browse and verify names at https://icon-sets.iconify.design/.

## React

Install:

```bash
npm install --save-dev @iconify/react
```

Use:

```tsx
import { Icon } from '@iconify/react'

export function SearchButton() {
  return (
    <button type="button" aria-label="Search">
      <Icon icon="lucide:search" width={18} height={18} />
    </button>
  )
}
```

Notes:

- `@iconify/react` loads icon data from the Iconify API when the `icon` prop is a string.
- For Next.js and SSR, the React component is client-only when using string icon names. Use Web Component, Tailwind, Unplugin Icons, or bundled icon data if server output or hydration stability matters.
- To avoid runtime API dependency, import icon data from a package such as `@iconify-icons/lucide/search` if the project already uses that pattern, or use modern `@iconify-json/{prefix}` tooling where appropriate.

## Web Component

Install:

```bash
npm install iconify-icon
```

Register once in the client entry:

```ts
import 'iconify-icon'
```

Use in HTML/JSX:

```html
<iconify-icon icon="mdi:home"></iconify-icon>
```

Prevent small layout shifts:

```css
iconify-icon {
  display: inline-block;
  width: 1em;
  height: 1em;
}
```

Use this option for HTML, web-component-friendly frameworks, or Next.js pages where shadow DOM and simpler hydration are desirable. In React, remember that custom elements use DOM attributes such as `class`, not always React component prop conventions.

## Tailwind CSS 4

Install:

```bash
npm i -D @iconify/tailwind4 @iconify-json/lucide
```

Add to CSS:

```css
@plugin "@iconify/tailwind4";
```

Use:

```html
<span class="icon-[lucide--search] size-5"></span>
```

Configure optional prefix or scale:

```css
@plugin "@iconify/tailwind4" {
  prefix: "iconify";
  scale: 1.2;
}
```

Install only the icon sets the project needs, for example `@iconify-json/lucide` or `@iconify-json/mdi-light`. Use `@iconify/json` only when the project really needs all open source icon sets.

## Tailwind CSS 3

Install:

```bash
npm i -D @iconify/tailwind @iconify-json/lucide
```

Dynamic selectors:

```js
const { addDynamicIconSelectors } = require('@iconify/tailwind')

module.exports = {
  content: ['./src/**/*.{js,ts,jsx,tsx,html}'],
  plugins: [addDynamicIconSelectors()],
}
```

Use:

```html
<span class="icon-[lucide--search] h-5 w-5"></span>
```

Clean selectors:

```js
const { addIconSelectors } = require('@iconify/tailwind')

module.exports = {
  content: ['./src/**/*.{js,ts,jsx,tsx,html}'],
  plugins: [addIconSelectors(['lucide', 'mdi-light'])],
}
```

Use:

```html
<span class="iconify lucide--search"></span>
```

Use dynamic selectors for simpler setup. Use clean selectors only when the project benefits from the shorter class shape and can explicitly list icon prefixes.

## CSS Masks and Background Images

For monotone icons that should follow text color, use a mask:

```css
.icon-search {
  display: inline-block;
  width: 1em;
  height: 1em;
  background-color: currentColor;
  --svg: url('https://api.iconify.design/lucide/search.svg');
  -webkit-mask-image: var(--svg);
  mask-image: var(--svg);
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;
  -webkit-mask-size: 100% 100%;
  mask-size: 100% 100%;
}
```

For palette icons, use a background image:

```css
.icon-file-tailwind {
  display: inline-block;
  width: 1em;
  height: 1em;
  background-image: url('https://api.iconify.design/vscode-icons/file-type-tailwind.svg');
  background-repeat: no-repeat;
  background-size: 100% 100%;
}
```

## Selection Checklist

- Need a single icon in a React client component: use `@iconify/react`.
- Need icons inside a Next.js server-rendered surface: prefer Web Component, Tailwind, Unplugin Icons, or bundled icon data.
- Need utility-class icons with Tailwind: use Iconify Tailwind plugin matching the Tailwind version.
- Need no network dependency at runtime: install icon data packages or generate SVG/CSS at build time.
- Need custom SVGs: convert them to an Iconify icon set or use project-local SVG components if there are only a few.

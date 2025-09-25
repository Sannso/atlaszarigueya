# Atlas Zarigueya

Paleta de colores, con base a la zarigueya

- Gris & Negro: neutral-400 +
- Crema: orange-100

## Colección de Contenido: Atlas (astro:content)

El Atlas utiliza Content Collections de Astro para estructurar páginas tipo documentación con soporte i18n. La colección está definida en `src/content/config.ts` como `atlas` con el siguiente schema (Zod):

Campos del schema:

- **title (string)**: Título visible de la página. Se muestra en el H1 y en el sidebar.
- **description (string, opcional)**: Resumen breve para SEO, listados o tarjetas.
- **order (number, default: 0)**: Orden dentro de su carpeta; menor valor aparece primero en el sidebar.
- **tags (string[], default: [])**: Etiquetas temáticas para filtrado/búsqueda futura.
- **image (string, opcional)**: Ruta a una imagen representativa de la página.
- **lang ("es" | "en")**: Idioma del documento. Debe coincidir con la carpeta (`src/content/atlas/es/` o `en/`).
- **draft (boolean, default: false)**: Si es `true`, la página se excluye de navegación/listados y del build público.

## Añadir contenido

Estructura base por idioma:

- `src/content/atlas/es/...`
- `src/content/atlas/en/...`

Ejemplo SIN subcarpeta (ES):

Ruta del archivo: `src/content/atlas/es/overview.md`

```md
---
title: Introducción al Atlas
lang: es
order: 1
description: Visión general y cómo navegar el Atlas.
tags: [inicio]
---

# Bienvenido al Atlas

Contenido...
```

URL resultante: `/atlas/es/overview`

Ejemplo CON subcarpeta (ES):

Ruta del archivo: `src/content/atlas/es/anatomia/intro.md`

```md
---
title: Anatomía - Introducción
lang: es
order: 10
description: Conceptos básicos de anatomía de la zarigüeya.
tags: [anatomia]
---

## Panorama general

Contenido...
```

URL resultante: `/atlas/es/anatomia/intro`

El mismo patrón aplica para `en/`.

## Rutas y Layout

- Páginas del Atlas:
  - `src/pages/atlas/index.astro` → redirige a `/atlas/es/`.
  - `src/pages/atlas/[lang]/index.astro` → portada por idioma (carga `overview`).
  - `src/pages/atlas/[lang]/[...slug].astro` → páginas dinámicas del Atlas.
- Layout del Atlas: `src/layouts/AtlasLayout.astro` (sidebar a la izquierda + contenido).
- Sidebar: `src/components/AtlasSidebar.astro` (lista plana con indentación por profundidad).

## i18n

- Cada documento tiene `lang` en el frontmatter y se ubica en la carpeta correspondiente (`es/` o `en/`).
- Las rutas incluyen el idioma: `/atlas/es/...` y `/atlas/en/...`.

## Imágenes y assets

- Estáticos globales (sin procesamiento): usar `public/` (p.ej., `public/videos/`).
- Imágenes optimizables: guardar en `src/assets/` y usarlas desde MDX o componentes con `<Image />` de Astro.

## Desarrollo

- Scripts en `package.json`:
  - `npm run dev` → servidor de desarrollo
  - `npm run build` → build
  - `npm run preview` → preview del build

Si el servidor no inicia, revisa la consola del terminal para errores de sintaxis en archivos `.astro` o frontmatter mal cerrado (`---`).

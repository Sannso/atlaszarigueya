import { defineCollection, z } from 'astro:content';

// Collection "atlas": estructura de contenido para páginas tipo documentación
// Cada archivo dentro de src/content/atlas/<lang>/... debe cumplir con este schema.

const atlas = defineCollection({
  // type "content" indica que los documentos provienen de archivos Markdown/MDX.
  type: 'content',
  schema: z.object({
    // title: Título visible de la página en el Atlas. Se muestra en el H1 y en el sidebar.
    title: z.string(),

    // description: Resumen corto de la página (opcional). Útil para SEO, listados y tarjetas.
    description: z.string().optional(),

    // order: Prioridad de orden dentro de su carpeta. Menor número aparece primero.
    // Si no se especifica, por defecto es 0. Útil para controlar el orden del sidebar.
    order: z.number().default(0),

    // tags: Etiquetas temáticas para filtrado/búsqueda futura. No afecta al enrutado.
    tags: z.array(z.string()).default([]),

    // image: Ruta (opcional) a una imagen representativa de la página. Puede ser relativa al documento.
    image: z.string().optional(),

    // lang: Idioma del documento. Debe corresponder con la carpeta del contenido (es/ o en/).
    lang: z.enum(['es', 'en']),

    // draft: Si es true, el documento se excluye de la navegación/listados y del build público.
    draft: z.boolean().default(false),
  }),
});

export const collections = { atlas };

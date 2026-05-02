#!/bin/bash

# Script para optimizar imágenes PNG manteniendo la transparencia
# Uso: ./optimize_transparent_images.sh [directorio]

if [ -z "$1" ]; then
    echo "Uso: $0 <directorio_de_imágenes>"
    echo "Ejemplo: $0 /path/to/images"
    exit 1
fi

INPUT_DIR="$1"
OUTPUT_DIR="${INPUT_DIR}/optimized_transparent"

# Crear directorio de salida
mkdir -p "$OUTPUT_DIR"

echo "Optimizando imágenes PNG con transparencia en: $INPUT_DIR"
echo "Directorio de salida: $OUTPUT_DIR"
echo ""

# Contador de imágenes procesadas
count=0

# Buscar y procesar archivos PNG recursivamente
find "$INPUT_DIR" -name "*.png" -type f | while read -r file; do
    # Saltar archivos en el directorio de salida
    if [[ "$file" == *"$OUTPUT_DIR"* ]]; then
        continue
    fi
    
    # Obtener ruta relativa
    rel_path="${file#$INPUT_DIR/}"
    output_file="$OUTPUT_DIR/$rel_path"
    
    # Crear directorio de salida si no existe
    mkdir -p "$(dirname "$output_file")"
    
    echo "Optimizando: $file -> $output_file"
    
    # Optimizar PNG manteniendo transparencia con sips
    sips -z 1200 1200 "$file" --out "$output_file" --setProperty format png
    
    # Obtener tamaños
    original_size=$(stat -f%z "$file")
    optimized_size=$(stat -f%z "$output_file")
    
    # Convertir a MB para mostrar
    original_mb=$(echo "scale=1; $original_size / 1024 / 1024" | bc)
    optimized_mb=$(echo "scale=1; $optimized_size / 1024 / 1024" | bc)
    
    echo "  Tamaño original: ${original_mb}M -> Optimizado: ${optimized_mb}M"
    
    count=$((count + 1))
done

echo ""
echo "Optimización completada. $count imágenes procesadas."
echo "Las imágenes optimizadas están en: $OUTPUT_DIR"
echo ""
echo "Para reemplazar las imágenes originales, ejecuta:"
echo "cp -r '$OUTPUT_DIR'/* '$INPUT_DIR/'"
echo "rm -rf '$OUTPUT_DIR'"

#!/bin/bash

# Script para optimizar imágenes en la carpeta public/images/atlas
# Reduce el tamaño de las imágenes manteniendo buena calidad

SOURCE_DIR="/Users/santiagososa/Documents/Development/atlaszarigueya/public/images/atlas"
OPTIMIZED_DIR="/Users/santiagososa/Documents/Development/atlaszarigueya/public/images/atlas/optimized"

# Crear directorio optimizado si no existe
mkdir -p "$OPTIMIZED_DIR"

# Función para optimizar una imagen
optimize_image() {
    local input_file="$1"
    local relative_path="${input_file#$SOURCE_DIR/}"
    local output_file="$OPTIMIZED_DIR/${relative_path%.*}.jpg"
    local output_dir=$(dirname "$output_file")
    
    # Crear directorio de salida si no existe
    mkdir -p "$output_dir"
    
    echo "Optimizando: $input_file -> $output_file"
    
    # Optimizar con sips: redimensionar a 1200px máximo, formato JPEG, calidad 80%
    sips -Z 1200 -s format jpeg -s formatOptions 80 "$input_file" --out "$output_file"
    
    # Mostrar ahorro de espacio
    local original_size=$(du -h "$input_file" | cut -f1)
    local optimized_size=$(du -h "$output_file" | cut -f1)
    echo "  Tamaño original: $original_size -> Optimizado: $optimized_size"
}

# Encontrar y optimizar todas las imágenes PNG y JPG
find "$SOURCE_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | while read -r file; do
    optimize_image "$file"
done

echo "Optimización completada. Las imágenes optimizadas están en: $OPTIMIZED_DIR"

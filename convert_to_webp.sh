#!/bin/bash

# Script para convertir PNG a WebP manteniendo la transparencia
# Uso: ./convert_to_webp.sh [directorio]

if [ -z "$1" ]; then
    echo "Uso: $0 <directorio_de_imágenes>"
    echo "Ejemplo: $0 /path/to/images"
    echo ""
    echo "Nota: Este script requiere que ImageMagick esté instalado."
    echo "Para instalar ImageMagick: brew install imagemagick"
    exit 1
fi

# Verificar si ImageMagick está instalado
if ! command -v magick &> /dev/null; then
    echo "Error: ImageMagick no está instalado."
    echo "Por favor, instale ImageMagick con: brew install imagemagick"
    exit 1
fi

INPUT_DIR="$1"
OUTPUT_DIR="${INPUT_DIR}/webp"

# Crear directorio de salida
mkdir -p "$OUTPUT_DIR"

echo "Convirtiendo imágenes PNG a WebP con transparencia en: $INPUT_DIR"
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
    
    # Cambiar extensión a .webp
    webp_path="${rel_path%.png}.webp"
    output_file="$OUTPUT_DIR/$webp_path"
    
    # Crear directorio de salida si no existe
    mkdir -p "$(dirname "$output_file")"
    
    echo "Convirtiendo: $file -> $output_file"
    
    # Convertir PNG a WebP manteniendo transparencia con ImageMagick
    magick "$file" -quality 85 -define webp:lossless=false -resize 1200x1200\> "$output_file"
    
    # Obtener tamaños
    original_size=$(stat -f%z "$file")
    webp_size=$(stat -f%z "$output_file")
    
    # Convertir a MB para mostrar
    original_mb=$(echo "scale=1; $original_size / 1024 / 1024" | bc)
    webp_mb=$(echo "scale=1; $webp_size / 1024 / 1024" | bc)
    
    echo "  Tamaño original: ${original_mb}M -> WebP: ${webp_mb}M"
    
    count=$((count + 1))
done

echo ""
echo "Conversión completada. $count imágenes convertidas."
echo "Las imágenes WebP están en: $OUTPUT_DIR"
echo ""
echo "Para usar las imágenes WebP, necesitarás actualizar las referencias en tus archivos .md"
echo "para que apunten a los archivos .webp en lugar de .png"

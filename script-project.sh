#!/bin/bash

# 🚀 Script para Cambiar Nombre del Proyecto (Configuración JSON)
# Este script usa archivos JSON para definir qué buscar y reemplazar

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Parámetros por defecto
CONFIG_FILE="project-config.json"
RULES_FILE="replacement-rules.json"

# Procesar argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--config)
            CONFIG_FILE="$2"
            shift 2
            ;;
        -r|--rules)
            RULES_FILE="$2"
            shift 2
            ;;
        -h|--help)
            echo -e "${GREEN}🚀 Script para Cambiar Nombre del Proyecto${NC}"
            echo ""
            echo "Uso: ./script-project.sh [-c config.json] [-r rules.json]"
            echo ""
            echo "Parámetros:"
            echo "  -c, --config    Archivo de configuración JSON (default: project-config.json)"
            echo "  -r, --rules     Archivo de reglas JSON (default: replacement-rules.json)"
            echo "  -h, --help      Mostrar esta ayuda"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Parámetro desconocido: $1${NC}"
            exit 1
            ;;
    esac
done

echo -e "${GREEN}🚀 Configurando proyecto usando archivos JSON...${NC}"
echo -e "${CYAN}📄 Archivo de configuración: ${WHITE}$CONFIG_FILE${NC}"
echo -e "${CYAN}📋 Archivo de reglas: ${WHITE}$RULES_FILE${NC}"

# Verificar que los archivos JSON existan
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}❌ Error: No se encontró el archivo de configuración '$CONFIG_FILE'${NC}"
    echo -e "${YELLOW}💡 Crea el archivo con la estructura requerida y ejecuta el script nuevamente.${NC}"
    exit 1
fi

if [ ! -f "$RULES_FILE" ]; then
    echo -e "${RED}❌ Error: No se encontró el archivo de reglas '$RULES_FILE'${NC}"
    exit 1
fi

# Verificar que jq esté instalado
if ! command -v jq &> /dev/null; then
    echo -e "${RED}❌ Error: 'jq' no está instalado${NC}"
    echo -e "${YELLOW}💡 Instala jq para procesar archivos JSON:${NC}"
    echo "   Ubuntu/Debian: sudo apt install jq"
    echo "   CentOS/RHEL: sudo yum install jq"
    echo "   macOS: brew install jq"
    exit 1
fi

echo -e "${GREEN}✅ Archivos JSON encontrados${NC}"

# Función para resolver placeholders
resolve_template() {
    local template="$1"
    local config_file="$2"
    local result="$template"
    
    # Obtener todas las claves del config
    local keys=$(jq -r 'keys[]' "$config_file")
    
    for key in $keys; do
        local value=$(jq -r ".$key" "$config_file")
        local placeholder="{{$key}}"
        result="${result//$placeholder/$value}"
    done
    
    echo "$result"
}

# Mostrar configuración
echo ""
echo -e "${YELLOW}📋 Configuración a aplicar:${NC}"
jq -r 'to_entries[] | "   \(.key): \(.value)"' "$CONFIG_FILE" | while read line; do
    echo -e "${WHITE}$line${NC}"
done

# Procesar archivos
echo ""
echo -e "${CYAN}🔄 Procesando archivos...${NC}"
files_processed=0
replacements_made=0

# Obtener lista de archivos del rules.json
files=$(jq -r '.files[]' "$RULES_FILE")

for file in $files; do
    if [ -f "$file" ]; then
        echo -e "${CYAN}📝 Procesando: $file${NC}"
        
        # Obtener reemplazos del rules.json
        jq -r '.replacements | to_entries[] | "\(.key):::\(.value)"' "$RULES_FILE" | while IFS=':::' read -r old_text new_template; do
            new_text=$(resolve_template "$new_template" "$CONFIG_FILE")
            
            if [ "$old_text" != "$new_text" ]; then
                # Verificar si el texto existe en el archivo antes de reemplazar
                if grep -q "$old_text" "$file"; then
                    # Para macOS usar sed -i ''
                    if [[ "$OSTYPE" == "darwin"* ]]; then
                        sed -i '' "s|$old_text|$new_text|g" "$file"
                    else
                        sed -i "s|$old_text|$new_text|g" "$file"
                    fi
                    echo -e "   ${GREEN}✅ '$old_text' → '$new_text'${NC}"
                    ((replacements_made++))
                fi
            fi
        done
        ((files_processed++))
    else
        echo -e "${YELLOW}⚠️ Archivo no encontrado: $file${NC}"
    fi
done

# Obtener valores específicos para el resumen
app_name=$(jq -r '.appName' "$CONFIG_FILE")
server_port=$(jq -r '.serverPort' "$CONFIG_FILE")

# Resumen final
echo ""
echo -e "${GREEN}🎉 ¡Configuración completada!${NC}"
echo -e "${YELLOW}� Resumen:${NC}"
echo -e "   ${WHITE}📝 Archivos procesados: $files_processed${NC}"
echo -e "   ${WHITE}🔄 Reemplazos realizados: $replacements_made${NC}"
echo -e "   ${WHITE}📦 Nuevo nombre del proyecto: $app_name${NC}"

echo ""
echo -e "${YELLOW}🚀 Próximos pasos:${NC}"
echo -e "   ${WHITE}1. Revisar los archivos modificados${NC}"
echo -e "   ${WHITE}2. Ejecutar: docker-compose -f docker-compose/compose.yml up -d${NC}"
echo -e "   ${WHITE}3. Acceder a: http://localhost:$server_port/v1/template${NC}"

# Hacer el script ejecutable
chmod +x script-project.sh

# Función para reemplazar texto en archivos
replace_in_file() {
    local file=$1
    local old_text=$2
    local new_text=$3
    
    if [ -f "$file" ]; then
        # Para macOS usar sed -i ''
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "s|$old_text|$new_text|g" "$file"
        else
            sed -i "s|$old_text|$new_text|g" "$file"
        fi
        echo -e "${GREEN}✅ Actualizado: $file${NC}"
    else
        echo -e "${YELLOW}⚠️ Archivo no encontrado: $file${NC}"
    fi
}

# Lista de archivos a modificar
files=(
    "README.md"
    "docker-compose/compose.yml"
    "pom.xml"
)

# Reemplazar en cada archivo
for file in "${files[@]}"; do
    echo -e "${CYAN}📝 Procesando: $file${NC}"
    replace_in_file "$file" "template-spring-boot" "$NEW_PROJECT_NAME"
done

# Verificar si hay otros archivos con el nombre del template
echo -e "${CYAN}🔍 Buscando referencias adicionales...${NC}"
additional_files=$(find . -name ".*" -prune -o -type f \( -name "*.md" -o -name "*.yml" -o -name "*.yaml" -o -name "*.xml" -o -name "*.properties" -o -name "*.java" \) -exec grep -l "template-spring-boot" {} \; 2>/dev/null | sort -u)

if [ ! -z "$additional_files" ]; then
    echo -e "${YELLOW}📋 Archivos adicionales encontrados con 'template-spring-boot':${NC}"
    echo "$additional_files" | while read -r line; do
        echo -e "   ${YELLOW}- $line${NC}"
    done
    echo -e "${CYAN}💡 Revisa estos archivos manualmente si es necesario.${NC}"
fi

echo ""
echo -e "${GREEN}🎉 ¡Cambio de nombre completado!${NC}"
echo -e "${WHITE}📦 Nuevo nombre del proyecto: $NEW_PROJECT_NAME${NC}"
echo -e "${WHITE}📝 Archivos actualizados: ${#files[@]}${NC}"
echo ""
echo -e "${YELLOW}🚀 Próximos pasos:${NC}"
echo -e "   ${WHITE}1. Revisar los archivos modificados${NC}"
echo -e "   ${WHITE}2. Ejecutar: docker-compose -f docker-compose/compose.yml up -d${NC}"

# Hacer el script ejecutable
chmod +x script-project.sh
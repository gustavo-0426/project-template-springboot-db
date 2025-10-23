# 📋 Guía de Uso - Script de Configuración Simplificado

## 🎯 Propósito

Este script facilita la configuración del proyecto usando **UN SOLO archivo JSON** con pares directos de "buscar: reemplazar". ¡Súper simple!

## 📂 Archivos necesarios:

- **`replacement-rules.json`** - Un solo archivo con todo lo necesario
- **`script-project.ps1`** - Script para Windows (PowerShell)

## ⚙️ Configuración - ¡SÚPER FÁCIL!

### Edita `replacement-rules.json`:
```json
{
  "replacements": {
    "TEMPLATE_REPO_NAME": "project-service-api-db",
    "TEMPLATE_PROJECT_NAME": "project",
    "TEMPLATE_SERVICE_NAME": "service",
    "TEMPLATE_MOTOR_DATABASE": "PostgreSQL"
  },
  "files": [
    "pom.xml",
    "README.md",
    "docker-compose/compose.yml"
  ]
}
```

**🎯 Concepto:** 
- **Lado izquierdo** = Texto que buscas en los archivos
- **Lado derecho** = Texto con el que lo reemplazas
- **files** = Lista de archivos donde buscar

## 🚀 Uso

### Windows (PowerShell)
```powershell
# Usar archivo por defecto (replacement-rules.json)
.\script-project.ps1

# Usar archivo personalizado
.\script-project.ps1 -ConfigFile "mi-config.json"
```

## ✅ Ejemplo paso a paso

### 1. **ANTES** (en tus archivos):
```
README.md: # template-spring-boot
pom.xml: <name>template-spring-boot</name>
```

### 2. **Tu configuración JSON:**
```json
{
  "replacements": {
    "template-spring-boot": "tienda-online"
  },
  "files": ["README.md", "pom.xml", "docker-compose/compose.yml"]
}
```

### 3. **DESPUÉS** (resultado automático):
```
README.md: # tienda-online
pom.xml: <name>tienda-online</name>
```

## 🎛️ Personalización

### Agregar más reemplazos:
```json
{
  "replacements": {
    "template-spring-boot": "mi-app",
    "MI_TEXTO_PERSONALIZADO": "mi-nuevo-texto",
    "OLD_PORT": "8080",
    "OLD_DESCRIPTION": "Nueva descripción increíble"
  }
}
```

### Agregar más archivos:
```json
{
  "files": [
    "README.md",
    "pom.xml",
    "mi-archivo-personalizado.txt",
    "docs/documentation.md"
  ]
}
```

## 📋 Requisitos

- **Windows:** PowerShell 5.0 o superior

## ⚠️ Recomendaciones

- **Valida JSON**: Asegúrate de que el JSON tenga sintaxis válida
- **Backup**: Haz respaldo antes de ejecutar el script
- **Nombres válidos**: Usa nombres compatibles con Docker (sin espacios)
- **Prueba primero**: Ejecuta en una copia del proyecto primero

## 🐛 Solución de problemas

### Error: "Archivo JSON inválido"
- Usa un validador JSON online
- Verifica comillas dobles (`"`)
- Verifica comas al final de líneas

### Script no encuentra archivos
- Ejecuta desde la raíz del proyecto
- Verifica que `replacement-rules.json` exista
- Revisa las rutas en la sección `files`

## 💡 Ejemplo completo real

```json
{
  "replacements": {
    "template-spring-boot": "inventario-api",
    "This is a template for spring boot project": "API para gestión de inventario empresarial",
    "8080": "8080",
    "PROJECT-TEMPLATE-SPRINGBOOT": "inventario-api"
  },
  "files": [
    "README.md",
    "docker-compose/compose.yml",
    "pom.xml",
    "src/main/resources/application.yml"
  ]
}
```

**🚀 Ejecutas:** `.\script-project.ps1`
**✅ Resultado:** Todos los archivos se actualizan automáticamente con tus valores!
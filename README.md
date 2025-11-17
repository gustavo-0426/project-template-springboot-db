<br>

# 🚀 TEMPLATE_REPO_NAME

[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://openjdk.java.net/projects/jdk/21/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4.1-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Aplicación** para proyecto Spring Boot con conexión a base de datos TEMPLATE_MOTOR_DATABASE. Estructura mínima lista para desarrollar tu aplicación.

## 📝 Instrucciones para personalizar esta plantilla

> **⚠️ IMPORTANTE:** Antes de realizar cualquier configuración o prueba, debes usar el script para reemplazar automáticamente todos los valores configurados en el archivo `replacement-rules.json`.

#### Windows (PowerShell):
```powershell
.\script-project.ps1
```

**Después de ejecutar el script, esta sección será eliminada automáticamente, de igual forma se elimina el archivo de configuracion `replacement-rules.json` y `script-project.ps1`.**

---
<br>

## 📋 Tabla de Contenidos

- [🚀 Características](#características)
- [📋 Requisitos Previos](#requisitos-previos)
- [⚡ Inicio Rápido (5 minutos)](#inicio-rapido)
- [💾 Configuración de Bases de Datos](settings-README.md)
- [📚 API Documentation](#api-documentation)
- [📞 Contacto](#contacto)

---
<br>

## <a id="características"></a>🚀 Características

- ✅ **Aplicación** Spring Boot TEMPLATE_SPRING_BOOT_VERSION + Java TEMPLATE_JAVA_VERSION
- 💾 **Soporte base de datos** TEMPLATE_MOTOR_DATABASE
- 🐳 **Docker Compose** configurado para orquestación de servicios
- 🔧 **Variables de entorno** para configuración sensible y mantenible
- 📦 **Dockerfile** optimizado con multi-stage build

---
<br>

## <a id="requisitos-previos"></a>📋 Requisitos Previos

- **Spring Boot TEMPLATE_SPRING_BOOT_VERSION**
- **Java TEMPLATE_JAVA_VERSION**
- **Maven 3.8+**
- **Docker** y **Docker Compose**
- **Git**

---
<br>

## <a id="inicio-rapido"></a>⚡ Inicio Rápido (5 minutos)

### 1️⃣ Variables de Entorno

Crear y configurar el archivo de variables de entorno:
```bash
cp docker-compose/env.example docker-compose/.env
```

### 2️⃣ Ejecutar Aplicación con Docker Compose

#### Construir y ejecutar:

```bash
docker-compose -f docker-compose/compose.yml up -d
```

#### Verificar contenedores activos:
```bash
docker-compose -f docker-compose/compose.yml ps
```

#### Ver logs en tiempo real:
```bash
docker-compose -f docker-compose/compose.yml logs -f
```

---
<br>

## <a id="api-documentation"></a>📚 API Documentation

### 📖 Swagger UI

Una vez que la aplicación esté ejecutándose, puedes acceder a la documentación interactiva:

- **Swagger UI:** [http://TEMPLATE_SERVER_HOST:TEMPLATE_SERVER_PORT/v1/template/swagger-ui/index.html](http://TEMPLATE_SERVER_HOST:TEMPLATE_SERVER_PORT/v1/template/swagger-ui/index.html)
- **OpenAPI JSON:** [http://TEMPLATE_SERVER_HOST:TEMPLATE_SERVER_PORT/v3/api-docs](http://TEMPLATE_SERVER_HOST:TEMPLATE_SERVER_PORT/v3/api-docs)

### 🗄️ Administración de Base de Datos

Para gestionar y administrar la base de datos TEMPLATE_MOTOR_DATABASE, se debe conectar al servidor:

- [http://TEMPLATE_SERVER_HOST:TEMPLATE_MOTOR_DATABASE_ADMIN_PORT](http://TEMPLATE_SERVER_HOST:TEMPLATE_MOTOR_DATABASE_ADMIN_PORT)

---
<br>

## <a id="contacto"></a>📞 Contacto 


### Gustavo Castro

**Ingeniero de Sistemas**  
**Especialista en Ingeniería de Software**  
**Desarrollador Backend Senior, Spring Boot, Node.js, Arquitectura Cloud (AWS)**  
**GitHub:** [github.com/gustavo-0426](https://github.com/gustavo-0426)  
**LinkedIn:** [linkedin.com/in/gustavo-castro-prasca](https://linkedin.com/in/gustavo-castro-prasca)

---

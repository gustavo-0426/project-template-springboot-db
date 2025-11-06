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

### 1️⃣ Ingresar a la ruta del proyecto

Abre una consola (Bash, Git Bash o PowerShell) y navega a la carpeta raíz de este repositorio:
```bash
cd /ruta/project-template-springboot-db
```

### 2️⃣ Ejecutar Aplicación con Docker Compose

#### Construir y ejecutar:

**Windows (PowerShell):**
```powershell
$env:SERVER_PORT="9999"; $env:DATABASE_HOST="postgres-db"; $env:DATABASE_PORT="5432"; $env:DATABASE_NAME="test"; $env:DATABASE_USERNAME="sa"; $env:DATABASE_PASSWORD="sa"; docker-compose -f docker-compose/compose.yml up -d
```

**Linux/Mac/Git Bash:**
```bash
SERVER_PORT=9999 DATABASE_HOST=postgres-db DATABASE_PORT=5432 DATABASE_NAME=test DATABASE_USERNAME=sa DATABASE_PASSWORD=sa docker-compose -f docker-compose/compose.yml up -d
```

#### Verificar contenedores activos:
```bash
docker-compose -f docker-compose/compose.yml ps
```

#### Ver logs en tiempo real:
```bash
docker-compose -f docker-compose/compose.yml logs -f
```

### 3️⃣ Verificar funcionamiento

#### Acceder a los endpoints:
- **Aplicación:** http://TEMPLATE_SERVER_HOST:TEMPLATE_SERVER_PORT/v1/template
- **Swagger UI:** http://TEMPLATE_SERVER_HOST:TEMPLATE_SERVER_PORT/v1/template/swagger-ui/index.html
- **PgAdmin Postgres:** http://TEMPLATE_SERVER_HOST:TEMPLATE_PGADMIN_PORT

---
<br>

## <a id="api-documentation"></a>📚 API Documentation

### 🔗 Endpoints principales

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| `GET` | `/v1/template` | Endpoint de prueba |
| `GET` | `/v1/template/swagger-ui/index.html` | Endpoint de documentación |

### 📖 Swagger UI

Una vez que la aplicación esté ejecutándose, puedes acceder a la documentación interactiva:

- **Swagger UI:** [http://TEMPLATE_SERVER_HOST:TEMPLATE_SERVER_PORT/v1/template/swagger-ui/index.html](http://TEMPLATE_SERVER_HOST:TEMPLATE_SERVER_PORT/v1/template/swagger-ui/index.html)
- **OpenAPI JSON:** [http://TEMPLATE_SERVER_HOST:TEMPLATE_SERVER_PORT/v3/api-docs](http://TEMPLATE_SERVER_HOST:TEMPLATE_SERVER_PORT/v3/api-docs)

### 🗄️ Administración de Base de Datos

Para gestionar y administrar la base de datos PostgreSQL, se debe conectar al servidor **pgAdmin**:

- **pgAdmin:** [http://TEMPLATE_SERVER_HOST:TEMPLATE_PGADMIN_PORT](http://TEMPLATE_SERVER_HOST:TEMPLATE_PGADMIN_PORT)

---
<br>

## <a id="contacto"></a>📞 Contacto 

### Gustavo Castro

**Ingeniero de Sistemas**
**Especialista en Ingenieria de Software**
**Desarrollador Backend Senior, Springboot, Nodejs, Arquitectura Cloud (AWS)   
**GitHub:** [github.com/gustavo-0426](https://github.com/gustavo-0426)  
**LinkedIn:** [linkedin.com/in/gustavo-castro-prasca](https://linkedin.com/in/gustavo-castro-prasca)

---

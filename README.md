<br>

# 🚀 TEMPLATE_REPO_NAME

[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://openjdk.java.net/projects/jdk/21/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4.1-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Aplicación** para proyecto Spring Boot con conexión a base de datos TEMPLATE_MOTOR_DATABASE. Estructura mínima lista para desarrollar tu aplicación.

## 📝 Instrucciones para personalizar esta plantilla

> **⚠️ IMPORTANTE:** Debes usar el script para reemplazar automaticamente todos los valores configurados en el archivo `replacement-rules.json` con la información específica de tu proyecto.

#### Windows (PowerShell):
```powershell
.\script-project.ps1 "mi-nuevo-proyecto"
```

#### Linux/Mac (Bash):
```bash
chmod +x script-project.sh
./script-project.sh "mi-nuevo-proyecto"
```

**Después de personalizar, elimina esta sección de instrucciones.**

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

- ✅ **Aplicación** Spring Boot 3.4.1 + Java 21
- 💾 **Soporte base de datos** PostgreSQL
- 🐳 **Docker Compose** configurado para orquestación de servicios
- 🔧 **Variables de entorno** para configuración sensible y mantenible
- 📦 **Dockerfile** optimizado con multi-stage build

---
<br>

## <a id="requisitos-previos"></a>📋 Requisitos Previos

- **Java 21** o superior
- **Maven 3.8+**
- **Docker** y **Docker Compose**
- **Git**

---
<br>

## <a id="inicio-rapido"></a>⚡ Inicio Rápido (5 minutos)

### 1️⃣ Clonar Repositorio

#### Clonar repositorio de GitHub:
```bash
git clone https://github.com/TEMPLATE_GITHUB_NAME/TEMPLATE_REPO_NAME.git mi-nuevo-proyecto
```

#### Ingresar a carpeta del proyecto:
```bash
cd mi-nuevo-proyecto
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

### 3️⃣ Verificar funcionamiento

#### Acceder a los endpoints:
- **Aplicación:** http://localhost:9999/v1/template
- **Swagger UI:** http://localhost:9999/v1/template/swagger-ui/index.html
- **PgAdmin Postgres:** http://localhost:8080

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

- **Swagger UI:** [http://localhost:9999/v1/template/swagger-ui/index.html](http://localhost:9999/v1/template/swagger-ui/index.html)
- **OpenAPI JSON:** [http://localhost:9999/v3/api-docs](http://localhost:9999/v3/api-docs)

### 🗄️ Administración de Base de Datos

Para gestionar y administrar la base de datos PostgreSQL, se debe conectar al servidor **pgAdmin**:

- **pgAdmin:** [http://localhost:8080](http://localhost:8080)

---
<br>

## <a id="contacto"></a>📞 Contacto

- **Autor:** Gustavo Castro
- **Aplicación Version:** 1.0.0
- **Spring Boot Version:** 3.4.1
- **Java Version:** 21

---

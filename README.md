# 🚀 [APP_NAME]

[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://openjdk.java.net/projects/jdk/21/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4.1-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Template base** para proyectos Spring Boot con conexión a base de datos. Estructura mínima lista para desarrollar tu aplicación.

## 📝 Instrucciones para personalizar esta plantilla

> **⚠️ IMPORTANTE:** Este es un README plantilla. Debes reemplazar todos los valores entre corchetes `[VALOR]` con la información específica de tu proyecto.

### Variables esenciales a reemplazar (Manual):

- `[APP_NAME]` → Nombre de la aplicación (nombre del repositorio, ejemplos: "template-spring-boot", "rental-inventory-api-mysql", "test-product-microservice-postgres")

### Variables de entorno (.env):

- `SERVER_PORT` → Puerto de la aplicación (rango: 9090-9999)
- `DATABASE_HOST` → Host de la base de datos (nombre del servicio Docker)
- `DATABASE_PORT` → Puerto de la base de datos (5432 para PostgreSQL)
- `DATABASE_NAME` → Nombre de la base de datos
- `DATABASE_USERNAME` → Usuario de la base de datos
- `DATABASE_PASSWORD` → Contraseña de la base de datos  

**Después de personalizar, elimina esta sección de instrucciones.**

<br>

---

## 📋 Tabla de Contenidos

- [🚀 Características](#características)
- [📋 Requisitos Previos](#requisitos-previos)
- [⚡ Inicio Rápido](#inicio-rapido)
- [📚 API Documentation](#api-documentation)
- [📞 Contacto](#contacto)

<br>

---

## <a id="características"></a>🚀 Características

- ✅ **Estructura base** Spring Boot 3.4.1 + Java 21
- 💾 **Conexión a base de datos** (PostgreSQL por defecto)
- 🐳 **Docker Compose** configurado y listo
- 🔧 **Variables de entorno** para configuración
- 📦 **Dockerfile** optimizado con multi-stage build

<br>

---

## <a id="requisitos-previos"></a>📋 Requisitos Previos

- **Java 21** o superior
- **Maven 3.8+**
- **Docker** y **Docker Compose**
- **Git**

<br>

---

## <a id="inicio-rapido"></a>⚡ Inicio Rápido (5 minutos)

### 1️⃣ Clonar Repositorio

#### Clonar repositorio de GitHub:
```bash
git clone https://github.com/gustavo-0426/[APP_NAME].git mi-nuevo-proyecto
```

#### Ingresar a carpeta del proyecto:
```bash
cd mi-nuevo-proyecto
```

### 2️⃣ Configurar variables básicas
```bash
# docker-compose/.env valores por default para base de datos postgres
SERVER_PORT=9999
DATABASE_HOST=postgres-db
DATABASE_PORT=5432
DATABASE_NAME=test-database
DATABASE_USERNAME=test_user
DATABASE_PASSWORD=test_password

```

### 3️⃣ Ejecutar con Docker Compose

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

### 4️⃣ Verificar funcionamiento

#### Acceder a los endpoints:
- **Aplicación:** http://localhost:9999/v1/template
- **Swagger UI:** http://localhost:9999/v1/template/swagger-ui/index.html

### 🔧 Comandos útiles adicionales

#### Detener servicios:
```bash
docker-compose -f docker-compose/compose.yml down
```

#### Reconstruir imágenes:
```bash
docker-compose -f docker-compose/compose.yml build --no-cache
```

#### Ver logs de un servicio específico:
```bash
docker-compose -f docker-compose/compose.yml logs [APP_NAME]
```

```bash
docker-compose -f docker-compose/compose.yml logs postgres-db
```

<br>

---

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

<br>

---

## <a id="contacto"></a>📞 Contacto

- **Autor:** Gustavo Castro
- **Template Version:** 1.0.0
- **Spring Boot Version:** 3.4.1
- **Java Version:** 21

<br>

---

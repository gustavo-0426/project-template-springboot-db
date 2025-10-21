# 🚀 [APP_NAME]

[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://openjdk.java.net/projects/jdk/21/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4.1-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Template base** para proyectos Spring Boot con conexión a base de datos. Estructura mínima lista para desarrollar tu aplicación.

## 📝 Instrucciones para personalizar esta plantilla

> **⚠️ IMPORTANTE:** Este es un README plantilla. Debes reemplazar todos los valores entre corchetes `[VALOR]` con la información específica de tu proyecto.

### Variables esenciales a reemplazar (Manual):

- `[APP_NAME]` → Nombre de la aplicación (debe ser el mismo nombre del repositorio, ejemplos: "template-spring-boot", "rental-inventory-api-mysql", "test-product-microservice-postgres")

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
```bash
# Clonar repositorio de GitHub
git clone https://github.com/gustavo-0426/[APP_NAME].git mi-nuevo-proyecto

# Ingresar a carpeta del proyecto
cd mi-nuevo-proyecto
```

### 2️⃣ Configurar variables básicas
```bash

# Edita docker-compose/.env con tus valores
SERVER_PORT=9091
DATABASE_HOST=postgres-db
DATABASE_PORT=5432
DATABASE_NAME=mi_base_datos
DATABASE_USERNAME=mi_usuario
DATABASE_PASSWORD=mi_password

```

### 3️⃣ Ejecutar con Docker Compose
```bash
# Construir y ejecutar
docker-compose -f docker-compose/compose.yml up -d

# Ver logs
docker-compose -f docker-compose/compose.yml logs -f
```

### 4️⃣ Verificar funcionamiento

- **Aplicación:** http://localhost:9091/v1/template

<br>

---

## <a id="contacto"></a>📞 Contacto

- **Autor:** [NOMBRE_AUTOR]
- **Template Version:** 1.0.0
- **Spring Boot Version:** 3.4.1
- **Java Version:** 21

<br>

---

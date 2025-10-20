# 🚀 [APP_NAME]

[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://openjdk.java.net/projects/jdk/21/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4.1-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Un microservicio RESTful desarrollado con **Spring Boot** que incluye autenticación, documentación automática con Swagger y base de datos.

## 📝 Instrucciones para personalizar esta plantilla

> **⚠️ IMPORTANTE:** Este es un README plantilla. Debes reemplazar todos los valores entre corchetes `[VALOR]` con la información específica de tu proyecto.

### Valores a reemplazar:

- `[APP_NAME]` → Nombre de la app con la siguiente estructura [PROYECTO]-[NOMBRE-SERVICIO]-[API|MICROSERVICE|BATCH]-[BASE DE DATOS (Opcional) ]
- `[DESCRIPCIÓN_FUNCIONALIDAD]` → Descripción de la funcionalidad principal (ej: "gestión de usuarios", "manejo de inventario")
- `[PUERTO_APLICACION]` → Puerto donde correrá tu aplicación (ej: 8080, 9090)
- `[USUARIO_BASE_DATOS]` → Usuario de tu base de datos
- `[CONTRASEÑA_BASE_DATOS]` → Contraseña de tu base de datos
- `[NOMBRE_BASE_DATOS]` → Nombre de tu base de datos
- `[DOCKER_REGISTRY]` → Tu usuario de Docker Hub (gustavo0426)
- `[CONTAINER_NAME]` → Nombre del contenedor Docker compuesto por: [PROYECTO]-[NOMBRE-SERVICIO]-[API|MICROSERVICE|BATCH]
- `[NETWORK_NAME]` → Nombre de la red Docker, compuesto por: [PROYECTO]-[NOMBRE-SERVICIO]-network
- `[PUERTO_HOST]` → Puerto del host para mapear
- `[ENTITIES]` → Plural de tu entidad (ej: users, orders, products)
- `[NOMBRE_AUTOR]` → Tu nombre

**Después de personalizar, elimina esta sección de instrucciones.**

## 📋 Tabla de Contenidos

- [🚀 Características](#características)
- [🏗️ Arquitectura](#arquitectura)
- [📋 Requisitos Previos](#requisitos-previos)
- [🐳 Configuración con Docker](#configuración-con-docker)
- [🔧 Variables de Entorno](#variables-de-entorno)
- [📡 Endpoints de la API](#endpoints-de-la-api)
- [🗄️ Base de Datos](#base-de-datos)
- [💻 Desarrollo Local](#desarrollo-local)
- [📞 Contacto](#contacto)

## <a id="características"></a>🚀 Características

- ✅ **RESTful API** para [DESCRIPCIÓN_FUNCIONALIDAD]
- 🔐 **Autenticación HTTP Basic** con Spring Security
- 📚 **Documentación automática** con Swagger/OpenAPI 3
- 💾 **Base de datos** [NOMBRE_BASE_DATOS]
- 🐳 **Contenedores** Docker
- 🧪 **Tests automatizados** incluidos
- 🔒 **Seguridad** implementada por defecto

## <a id="arquitectura"></a>🏗️ Arquitectura

```
┌─────────────────┐    ┌──────────────────┐    ┌──────────────────────┐
│   API Client    │────│   [PROJECT] API  │────│ [NOMBRE_BASE_DATOS]  │
│  (REST calls)   │    │ (Spring Boot)    │    │                      │
└─────────────────┘    └──────────────────┘    └──────────────────────┘
```

## <a id="requisitos-previos"></a>📋 Requisitos Previos

- **Java 21** o superior
- **Maven 3.8+**
- **Docker** y **Docker Compose**
- **Git**

## <a id="configuración-con-docker"></a>🐳 Configuración con Docker

### Estructura de Archivos Docker

```
docker-compose/
├── docker-compose.yml    # Orquestación de servicios
├── Dockerfile            # Imagen del microservicio
└── .env                  # Variables de entorno
```

### 1. Crear archivo de variables de entorno

Crea el archivo `.env` en la carpeta `docker-compose/`:

```bash
# Configuración de la aplicación
SERVER_PORT=[PUERTO_APLICACION]

# Configuración de la base de datos
DATABASE_USERNAME=[USUARIO_BASE_DATOS]
DATABASE_PASSWORD=[CONTRASEÑA_BASE_DATOS]
DATABASE_NAME=[NOMBRE_BASE_DATOS]
```

### 2. Configuración del Docker Compose

El archivo `docker-compose.yml` está configurado para:

```yaml
services:
  [NOMBRE-SERVICIO]:                        # Nombre del servicio obtenido del nombre de la aplicacion [APP_NAME]       
    build: 
      context: ../                          # Contexto desde la raíz del proyecto
      dockerfile: docker-compose/Dockerfile # Ubicación del Dockerfile
    image: [DOCKER_REGISTRY]/[APP_NAME]:latest
    container_name: [CONTAINER_NAME]
    restart: always
    environment:                           # Variables de entorno desde .env
      DB_USERNAME: ${DATABASE_USERNAME}
      DB_PASSWORD: ${DATABASE_PASSWORD}
      DB_NAME: ${DATABASE_NAME}
      SERVER_PORT: ${SERVER_PORT}
    networks:
      - [NETWORK_NAME]
    ports:
      - "[PUERTO_HOST]:${SERVER_PORT}"     # Puerto expuesto
```

### 3. Estructura del Dockerfile

El `Dockerfile` utiliza **multi-stage build** para optimizar el tamaño:

**Stage 1: Build** (eclipse-temurin:21-jdk)
- ✅ Instala Maven
- ✅ Copia dependencias (`pom.xml`)
- ✅ Descarga dependencias (cacheable)
- ✅ Copia código fuente
- ✅ Compila el proyecto

**Stage 2: Runtime** (eclipse-temurin:21-jre-alpine)
- ✅ Imagen más ligera (Alpine Linux)
- ✅ Usuario no-root para seguridad
- ✅ Solo el JAR compilado
- ✅ Puerto expuesto

### 4. Comandos para Docker Hub

```bash
# Login en Docker Hub
docker login

# Construir imagen
docker build -f docker-compose/Dockerfile -t [DOCKER_REGISTRY]/[APP_NAME]:latest .

# Subir al repositorio
docker push [DOCKER_REGISTRY]/[APP_NAME]:latest

# Descargar imagen
docker pull [DOCKER_REGISTRY]/[APP_NAME]:latest
```

## <a id="variables-de-entorno"></a>🔧 Variables de Entorno

| Variable | Descripción | Valor por Defecto |
|----------|-------------|------------------|
| `SERVER_PORT` | Puerto de la aplicación | `[PUERTO_APLICACION]` |
| `DATABASE_USERNAME` | Usuario de base de datos | `[USUARIO_BASE_DATOS]` |
| `DATABASE_PASSWORD` | Contraseña de base de datos | `[CONTRASEÑA_BASE_DATOS]` |
| `DATABASE_NAME` | Nombre de la base de datos | `[NOMBRE_BASE_DATOS]` |

## <a id="endpoints-de-la-api"></a>📡 Endpoints de la API

### Base URL
```
http://[HOST]:[PUERTO_APLICACION]
```

### Documentación Swagger
```
http://[HOST]:[PUERTO_APLICACION]/[API-VERSION]/template/swagger-ui/index.html
```

### Endpoints Principales

| Método | Endpoint | Descripción | Autenticación |
|--------|----------|-------------|---------------|
| `GET` | `/api/v1/[ENTITIES]` | Listar entidades | ✅ Requerida |
| `GET` | `/api/v1/[ENTITIES]/{id}` | Obtener entidad | ✅ Requerida |
| `POST` | `/api/v1/[ENTITIES]` | Crear entidad | ✅ Admin |
| `PUT` | `/api/v1/[ENTITIES]/{id}` | Actualizar entidad | ✅ Admin |
| `DELETE` | `/api/v1/[ENTITIES]/{id}` | Eliminar entidad | ✅ Admin |

## <a id="base-de-datos"></a>🗄️ Base de Datos

### Acceso a la Consola

1. **URL de acceso:** http://localhost:[PUERTO_APLICACION]/h2-console
2. **Configuración de conexión:**
   - **JDBC URL:** `jdbc:h2:mem:[NOMBRE_BD]`
   - **Usuario:** `sa`
   - **Contraseña:** `password`

### Datos Iniciales

El sistema carga automáticamente:

**Entidades principales:**
- [DESCRIBIR_DATOS_INICIALES]

**Usuarios:**
- [USERNAME] (admin) / test (user)

## <a id="desarrollo-local"></a>💻 Desarrollo Local


### Ejecución con Docker

```bash
# Construir y ejecutar en segundo plano desde la raiz del proyecto
docker-compose -f .\docker-compose\docker-compose.yml up -d

# Detener servicios
docker-compose -f .\docker-compose\docker-compose.yml down
```

---

## <a id="contacto"></a>📞 Contacto

- **Autor:** [NOMBRE_AUTOR]

---

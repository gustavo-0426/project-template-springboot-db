# 💾 Configuración de Bases de Datos

Este template soporta múltiples bases de datos. A continuación se detalla la configuración para cada una:

## Bases de Datos Soportadas

| Base de Datos | Puerto por Defecto | Dependencia Maven |
|---------------|-------------------|-------------------|
| PostgreSQL | 5432 | `postgresql`|
| MySQL | 3306 | `mysql-connector-j`|
| SQL Server | 1433 | `mssql-jdbc`|
| MongoDB | 27017 | `spring-boot-starter-data-mongodb` |
| H2 | N/A | `h2` |

---

## 🐘 PostgreSQL (Configuración Actual)

**1️⃣ Variables de Entorno (docker-compose\.env):**
```bash
DATABASE_HOST=postgres-db
DATABASE_PORT=5432
DATABASE_NAME=postgres-database-name
DATABASE_USERNAME=postgres_user
DATABASE_PASSWORD=postgres_password
```

**2️⃣ Dependencia Maven:**
```xml
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
</dependency>
```

**3️⃣ Configuración application-dev.yml:**
```yaml
spring:
  datasource:
    url: jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_DATABASE}?sslmode=disable
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
    driver-class-name: org.postgresql.Driver
  jpa:
    show-sql: true
    database-platform: org.hibernate.dialect.PostgreSQLDialect
    hibernate:
      ddl-auto: update
```

**4️⃣ Docker Compose (compose.yml):**
```yaml
services:
  project:
    # ... (configuración existente)
    depends_on:
      - postgres-db

  postgres-db:
    image: postgres:16-alpine
    container_name: project-db
    restart: always
    environment:
      POSTGRES_USER: ${DATABASE_USERNAME}
      POSTGRES_PASSWORD: ${DATABASE_PASSWORD}
      POSTGRES_DB: ${DATABASE_NAME}
    ports:
      - "5432:5432"
    networks:
      - project_network
      - shared_pgadmin_network
    volumes:
      - project_postgres_data:/var/lib/postgresql/data

networks:
  # ... (configuración existente)

volumes:
  project_mysql_data:
```

---

## 🐬 MySQL

**1️⃣ Variables de Entorno (docker-compose\.env):**
```bash
DATABASE_HOST=mysql-db
DATABASE_PORT=3306
DATABASE_NAME=mysql-database-name
DATABASE_USERNAME=mysql_user
DATABASE_PASSWORD=mysql_password
```

**2️⃣ Dependencia Maven:**
```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
</dependency>
```

**3️⃣ Configuración application-dev.yml:**
```yaml
spring:
  datasource:
    url: jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_DATABASE}?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
    driver-class-name: com.mysql.cj.jdbc.Driver
  jpa:
    show-sql: true
    database-platform: org.hibernate.dialect.MySQLDialect
    hibernate:
      ddl-auto: update
```

**4️⃣ Docker Compose (compose.yml):**
```yaml
services:
  project:
    # ... (configuración existente)
    depends_on:
      - mysql-db

  mysql-db:
    image: mysql:8.0
    container_name: project-mysql-db
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: ${DATABASE_PASSWORD}
      MYSQL_DATABASE: ${DATABASE_NAME}
      MYSQL_USER: ${DATABASE_USERNAME}
      MYSQL_PASSWORD: ${DATABASE_PASSWORD}
    ports:
      - "3306:3306"
    networks:
      - project_network
    volumes:
      - project_mysql_data:/var/lib/mysql

networks:
  # ... (configuración existente)

volumes:
  project_mysql_data:
```

---

## 🏢 SQL Server

**1️⃣ Variables de Entorno (docker-compose\.env):**
```bash
DATABASE_HOST=sqlserver-db
DATABASE_PORT=1433
DATABASE_NAME=sqlserver-database-name
DATABASE_USERNAME=sqlserver_user
DATABASE_PASSWORD=sqlserver_password
```

**2️⃣ Dependencia Maven:**
```xml
<dependency>
    <groupId>com.microsoft.sqlserver</groupId>
    <artifactId>mssql-jdbc</artifactId>
</dependency>
```

**3️⃣ Configuración application-dev.yml:**
```yaml
spring:
  datasource:
    url: jdbc:sqlserver://${DB_HOST}:${DB_PORT};databaseName=${DB_DATABASE};encrypt=false;trustServerCertificate=true
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
    driver-class-name: com.microsoft.sqlserver.jdbc.SQLServerDriver
  jpa:
    show-sql: true
    hibernate:
      dialect: org.hibernate.dialect.SQLServerDialect
      ddl-auto: update
```

**4️⃣ Docker Compose (compose.yml):**
```yaml
services:
  project:
    # ... (configuración existente)
    depends_on:
      - sqlserver-db

  sqlserver-db:
    image: mcr.microsoft.com/mssql/server:2022-latest
    container_name: project-sqlserver-db
    restart: always
    environment:
      SA_PASSWORD: ${DATABASE_PASSWORD}
      ACCEPT_EULA: Y
      MSSQL_PID: Express
    ports:
      - "1433:1433"
    networks:
      - project_network
    volumes:
      - project_sqlserver_data:/var/opt/mssql

networks:
  # ... (configuración existente)

volumes:
  project_sqlserver_data:
```

---

## 🍃 MongoDB

**1️⃣ Variables de Entorno (docker-compose\.env):**
```bash
DATABASE_HOST=mongo-db
DATABASE_PORT=27017
DATABASE_NAME=mongo-database-name
DATABASE_USERNAME=mongo_user
DATABASE_PASSWORD=mongo_password
```

**2️⃣ Dependencia Maven:**
```xml
<!-- REMOVER spring-boot-starter-data-jpa -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-mongodb</artifactId>
</dependency>
```

**3️⃣ Configuración application-dev.yml:**
```yaml
spring:
  data:
    mongodb:
      host: ${DB_HOST}
      port: ${DB_PORT}
      database: ${DB_DATABASE}
      username: ${DB_USERNAME}
      password: ${DB_PASSWORD}
      authentication-database: admin
```

**4️⃣ Docker Compose (compose.yml):**
```yaml
services:
  project:
    # ... (configuración existente)
    depends_on:
      - mongo-db

  mongo-db:
    image: mongo:7.0
    container_name: project-mongo-db
    restart: always
    environment:
      MONGO_INITDB_ROOT_USERNAME: ${DATABASE_USERNAME}
      MONGO_INITDB_ROOT_PASSWORD: ${DATABASE_PASSWORD}
      MONGO_INITDB_DATABASE: ${DATABASE_NAME}
    ports:
      - "27017:27017"
    networks:
      - project_network
    volumes:
      - project_mongo_data:/data/db

networks:
  # ... (configuración existente)

volumes:
  project_mongo_data:
```

**⚠️ Nota MongoDB:** Requiere cambios en el código para usar `@Document` en lugar de `@Entity`.

---

## 🧪 H2 (Base de Datos en Memoria - Desarrollo/Testing)

**1️⃣ Variables de Entorno (docker-compose\.env):**
```bash
DATABASE_NAME=h2-database-name
DATABASE_USERNAME=h2_user
DATABASE_PASSWORD=h2_password
```

**2️⃣ Dependencia Maven:**
```xml
<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
    <scope>runtime</scope>
</dependency>
```

**3️⃣ Configuración application-dev.yml:**
```yaml
spring:
  datasource:
    url: jdbc:h2:mem:${DB_DATABASE}
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
    driver-class-name: org.h2.Driver
  jpa:
    show-sql: true
    hibernate:
      ddl-auto: create-drop
  h2:
    console:
      enabled: true
      path: /h2-console
```

**4️⃣ Docker Compose:** No requiere servicio de base de datos externa.

**Acceso H2 Console:** http://localhost:9999/h2-console

---

## <a id="guia-migracion"></a>🔄 Guía de Migración entre Bases de Datos

**Pasos para cambiar de PostgreSQL a otra BD:**

1. **Modificar pom.xml** - Cambiar dependencias
2. **Actualizar .env** - Ajustar variables de entorno
3. **Modificar application-dev.yml** - Cambiar configuración
4. **Actualizar compose.yml** - Cambiar servicio de BD
5. **Reconstruir proyecto:**
   ```bash
   docker-compose -f docker-compose/compose.yml down
   docker-compose -f docker-compose/compose.yml build --no-cache
   docker-compose -f docker-compose/compose.yml up -d
   ```

## 🛠️ Herramientas de Administración Recomendadas

| Base de Datos | Herramienta | Puerto/Acceso |
|---------------|-------------|---------------|
| PostgreSQL | pgAdmin | http://localhost:5050 |
| MySQL | phpMyAdmin / MySQL Workbench | http://localhost:8080 |
| SQL Server | SQL Server Management Studio | localhost:1433 |
| MongoDB | MongoDB Compass | localhost:27017 |
| H2 | H2 Console | http://localhost:9999/h2-console |

---
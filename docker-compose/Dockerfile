FROM eclipse-temurin:21-jdk AS build

LABEL org.opencontainers.image.authors="gustavoprasca@hotmail.com"

# Instalar Maven
RUN apt-get update && \
    apt-get install -y maven ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    update-ca-certificates

WORKDIR /app/TEMPLATE_REPO_NAME

# Copiar solo pom.xml para cachear dependencias
COPY ../pom.xml .

# Descargar todas las dependencias (se cachea si pom.xml no cambia)
RUN mvn dependency:go-offline -B

# Copiar código fuente
COPY ../src ./src

# Compilar usando dependencias ya descargadas
RUN mvn clean package -DskipTests -B


FROM eclipse-temurin:21-jre-alpine

# Variable de entorno por defecto para el puerto del servidor 
ENV SERVER_PORT=8080

# Crear usuario no-root para seguridad
RUN addgroup -g 1001 -S appuser && \
    adduser -S -D -H -u 1001 -s /sbin/nologin -G appuser appuser

WORKDIR /home/TEMPLATE_REPO_NAME

# Copiar JAR y cambiar permisos
COPY --from=build /app/TEMPLATE_REPO_NAME/target/*.jar ./TEMPLATE_REPO_NAME.jar

# Cambiar a usuario no-root
USER appuser

# Exponer el puerto configurado
EXPOSE ${SERVER_PORT}

ENTRYPOINT ["java","-jar","./TEMPLATE_REPO_NAME.jar"]
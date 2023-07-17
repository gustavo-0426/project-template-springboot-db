FROM amazoncorretto:11.0.19
MAINTAINER Gustavo Castro

RUN mkdir -p /home/template-spring-boot
WORKDIR /home/template-spring-boot
COPY ./target/template-spring-boot-1.0.0.jar ./template-spring-boot-1.0.0.jar
CMD ["java", "-jar", "/home/template-spring-boot/template-spring-boot-1.0.0.jar"]
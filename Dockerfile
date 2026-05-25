# Etapa 1: Compilación con Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY Springboot-API-REST/pom.xml .
COPY Springboot-API-REST/src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Imagen final liviana de ejecución (Corregida)
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]

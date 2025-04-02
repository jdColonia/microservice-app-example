FROM maven:3.8.4-openjdk-8 AS build
WORKDIR /app
COPY . .
RUN mvn clean package

FROM openjdk:8-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

ENV JWT_SECRET=PRFT \
    SERVER_PORT=8080 

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
FROM openjdk:18-jdk-alpine as mvn-build
WORKDIR /app/build
COPY ../demo-sender/src ./src
COPY ../demo-sender/pom.xml .
COPY .mvn .mvn
COPY ../demo-sender/mvnw .
RUN ./mvnw clean install -Dmaven.test.skip=true

FROM openjdk:18-jre-alpine
WORKDIR /app
COPY --from=mvn-build /app/build/target/*.jar ./spring-app.jar
CMD ["java", "-jar", "/app/spring-app.jar"]


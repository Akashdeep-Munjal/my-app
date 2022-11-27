FROM maven:3 as build
WORKDIR  /my-app
COPY ./my-app/ .
RUN mvn clean install

FROM openjdk:8-jre
WORKDIR /my-app
COPY --from=build /my-app/target/my-app-0.0.1-SNAPSHOT.jar /my-app/
EXPOSE 8080
CMD ["java", "-jar", "my-app-0.0.1-SNAPSHOT.jar"]

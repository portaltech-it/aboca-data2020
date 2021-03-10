# the first stage of our build will use a maven 3.6.1 parent image
FROM maven:3.6.3-openjdk-11-slim AS build

# copy the pom and src code to the container
COPY /asm ./

# package our application code
RUN mvn clean package -DskipTests

FROM openjdk:11-jre-slim

# copy only the artifacts we need from the first stage and discard the rest
COPY --from=build /target/*.jar /asm.jar

# define entrypoint
ENTRYPOINT ["java","-jar","/asm.jar"]
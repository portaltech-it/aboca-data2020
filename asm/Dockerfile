# the first stage of our build will use a maven 3.6.1 parent image
FROM maven:openjdk:11-jre-slim AS MAVEN_BUILD

# copy the pom and src code to the container
COPY ./ ./

# package our application code
RUN mvn clean package -DskipTests

# copy only the artifacts we need from the first stage and discard the rest
COPY --from=MAVEN_BUILD /target/*.jar /asm.jar

# define entrypoint
ENTRYPOINT ["java","-jar","/asm.jar"]
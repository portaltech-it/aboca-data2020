FROM openjdk:11-jre-slim
VOLUME /tmp
COPY target/*.jar asm.jar
ENTRYPOINT ["java","-jar","/asm.jar"]
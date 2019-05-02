FROM openjdk:8-jdk-alpine
VOLUME /tmp
ADD target/discovery-service-0.1.jar discovery-service.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/discovery-service.jar"]
EXPOSE 8761
FROM openjdk:8 AS BUILD_IMAGE
#RUN apt update && apt install maven -y
RUN apt-get update && apt install maven -y
COPY . .
RUN mvn package -DskipTests

FROM tomcat:8-jre11

#remove default 
RUN rm -rf /usr/local/tomcat/webapps/*

#copy build 
COPY --from=BUILD_IMAGE target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

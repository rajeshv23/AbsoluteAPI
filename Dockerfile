# base image
FROM tomcat:8.5-jre8

# set environment variable for app
ENV ABS_API_ROOT /usr/src/absolute-api

# update packages and install jdk
RUN apt-get update && apt-get install -y default-jdk

# set
WORKDIR $ABS_API_ROOT

# copy content from the current directory to the api directory
COPY . $ABS_API_ROOT/

# deploy the application on tomcat
RUN cp absolute-api.war $CATALINA_BASE/webapps/absolute-api.war
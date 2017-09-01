FROM tomcat:alpine
MAINTAINER Wei Zhong "zhongwei99@163.com"

ENV ACTIVITI_VERSION 6.0.0
ENV MYSQL_CONNECTOR_JAVA_VERSION 5.1.44

RUN apk --no-cache add openssl 

RUN wget https://github.com/Activiti/Activiti/releases/download/activiti-${ACTIVITI_VERSION}/activiti-${ACTIVITI_VERSION}.zip -O /tmp/activiti.zip && \
 	  unzip /tmp/activiti.zip -d /usr/local && \
	  unzip /usr/local/activiti-${ACTIVITI_VERSION}/wars/activiti-app.war -d /usr/local/tomcat/webapps/activiti-app && \
	  unzip /usr/local/activiti-${ACTIVITI_VERSION}/wars/activiti-rest.war -d /usr/local/tomcat/webapps/activiti-rest && \
	  unzip /usr/local/activiti-${ACTIVITI_VERSION}/wars/activiti-admin.war -d /usr/local/tomcat/webapps/activiti-admin && \
	  rm -rf /usr/local/activiti-${ACTIVITI_VERSION} /tmp/activiti.zip

RUN wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}.tar.gz -O /tmp/mysql-connector-java.tar.gz && \
	  tar xzf /tmp/mysql-connector-java.tar.gz -d /tmp && \
	  cp /tmp/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}-bin.jar /usr/local/tomcat/webapps/activiti-rest/WEB-INF/lib/ && \
	  cp /tmp/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}-bin.jar /usr/local/tomcat/webapps/activiti-app/WEB-INF/lib/ && \
	  cp /tmp/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}-bin.jar /usr/local/tomcat/webapps/activiti-admin/WEB-INF/lib/ && \
	  rm -rf /tmp/mysql-connector-java.zip /tmp/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}

WORKDIR $CATALINA_HOME
EXPOSE 8080
CMD ["catalina.sh", "run"]

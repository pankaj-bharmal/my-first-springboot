FROM localhost:5000/openjdk:17
ENV TZ=Asia/Calcutta
WORKDIR /app
ARG JAR_FILE=my-first-springboot/target/*.jar
COPY ${JAR_FILE} my-first-springboot-app.jar
COPY my-first-springboot/target/classes/application.properties application.properties
# COPY my-first-springboot/target/classes/log4j2.xml log4j2.xml
# COPY my-first-springboot/target/classes/unlimited.hitachi.jks unlimited.hitachi.jks
EXPOSE 9090
ENTRYPOINT ["java", \
  "-server", \
  "-Xmx1024m", \
  "-XX:+HeapDumpOnOutOfMemoryError", \
  "-XX:+UseG1GC", \
  "-XX:+UnlockExperimentalVMOptions", \
  "-XX:+DoEscapeAnalysis", \
  "-XX:+UseCompressedOops", \
  "-XX:MaxGCPauseMillis=400", \
  "-XX:GCPauseIntervalMillis=8000", \
  "-jar", \
  "my-first-springboot-app.jar"]

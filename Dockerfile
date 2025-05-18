FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY build/libs/cloud-app-0.0.1-SNAPSHOT.jar app.jar

# Create a non-root user
RUN useradd -m -u 1000 appuser
USER appuser

# Set environment variables
ENV JAVA_OPTS="-Xms512m -Xmx512m"

EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
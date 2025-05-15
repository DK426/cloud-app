# Build stage
FROM gradle:8.5-jdk21 AS build
WORKDIR /app
COPY . .
RUN gradle build --no-daemon

# Run stage
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --from=build /app/build/libs/cloud-app-0.0.1-SNAPSHOT.jar app.jar

# Create a non-root user
RUN useradd -m -u 1000 appuser
USER appuser

# Set environment variables
ENV JAVA_OPTS="-Xms512m -Xmx512m"

EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
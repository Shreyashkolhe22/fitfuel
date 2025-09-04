# Use OpenJDK 17
FROM eclipse-temurin:17-jdk-jammy

# Set working directory
WORKDIR /app

# Copy Maven wrapper and project files
COPY mvnw .
COPY .mvn/ .mvn/
COPY pom.xml .
COPY src/ src/

# Build the project
RUN ./mvnw clean package

# Expose the port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "target/FitFuel-0.0.1-SNAPSHOT.jar"]

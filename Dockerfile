FROM eclipse-temurin:25-alpine

WORKDIR /app

COPY . /app

RUN chmod +x /app/entrypoint.sh

ENV APPLICATION_PORT=25565

EXPOSE ${APPLICATION_PORT}

ENTRYPOINT ["/bin/sh", "-c", "/app/entrypoint.sh"]
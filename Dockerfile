FROM eclipse-temurin:25

WORKDIR /app

COPY . /app

ENV APPLICATION_PORT=25565

EXPOSE ${APPLICATION_PORT}

ENTRYPOINT ["/bin/sh", "-c", "/app/entrypoint.sh"]
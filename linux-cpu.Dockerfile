FROM python:3.12-slim-bookworm

ENV UV_VERSION=0.5.29

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y curl


ADD https://astral.sh/uv/${UV_VERSION}/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin/:$PATH"

WORKDIR /app

COPY pyproject.toml hello.py /app/

RUN uv --version \
    && uv sync --group linux --group linux-cpu --no-group cuda

CMD ["uv", "run", "python", "hello.py"]
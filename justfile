default:
    just --list

format:
    uv run ruff check --fix
    uv run ruff format

test:
    uv run pytest -vvv

makemigrations:
    uv run app/manage.py makemigrations

develop: makemigrations format test

up-local:
    uv run app/manage.py migrate --no-input
    uv run app/manage.py runserver 0.0.0.0:8080

build:
    docker compose -f compose.yaml build

simulate-ci: build
    docker compose -f compose.yaml run --remove-orphans --rm app sh -c 'uv run ruff check'
    docker compose -f compose.yaml run --remove-orphans --rm app sh -c 'uv run pytest'

up:
    docker compose -f compose.yaml build
    docker compose -f compose.yaml up

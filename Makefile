.PHONY: help install dev build start docker-up docker-down prisma-migrate prisma-studio clean logs

help:
	@echo "=== La27 TypeScript API - Available Commands ==="
	@echo "make install         - Install dependencies"
	@echo "make dev             - Run in development mode (with hot reload)"
	@echo "make build           - Build TypeScript to JavaScript"
	@echo "make start           - Run compiled app (production)"
	@echo "make docker-up       - Start API and PostgreSQL containers"
	@echo "make docker-down     - Stop all containers"
	@echo "make docker-build    - Build Docker image"
	@echo "make docker-logs     - View container logs"
	@echo "make prisma-migrate  - Run database migrations"
	@echo "make prisma-studio   - Open Prisma Studio (DB GUI)"
	@echo "make prisma-generate - Generate Prisma client"
	@echo "make clean           - Remove dist, node_modules, and logs"
	@echo "make lint            - Run linter (if configured)"

install:
	npm install

dev:
	npm run dev

build:
	npm run build

start:
	npm start

docker-up:
	docker compose up -d
	@echo "API running at http://localhost:3000"
	@echo "PostgreSQL at localhost:5432"

docker-down:
	docker compose down

docker-build:
	docker compose build

docker-logs:
	docker compose logs -f

prisma-migrate:
	npx prisma migrate dev

prisma-studio:
	npx prisma studio

prisma-generate:
	npx prisma generate

clean:
	rm -rf dist/
	rm -rf node_modules/
	rm -f *.log
	docker compose down -v
	@echo "Cleaned up!"

TYPE_CHECK:
	npx tsc --noEmit

# Development workflow
dev-setup: install prisma-migrate
	@echo "Development environment ready!"

# Production deployment
prod-deploy: build docker-build docker-up
	@echo "Production deployment complete!"

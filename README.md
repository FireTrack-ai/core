# 🔥 Firetrack.ai — AI-Powered Dividend & Portfolio Tracker

![Go](https://img.shields.io/badge/backend-Go-blue)
![Postgres](https://img.shields.io/badge/database-PostgreSQL-blue)
![Docker](https://img.shields.io/badge/containerized-Docker-blue)

Firetrack.ai is an application for automatic import and analysis of investment portfolios.  
It aggregates data from multiple brokers and markets, builds a dividend calendar, calculates returns, and provides **AI insights** on how to improve your portfolio (rebalancing, taxes, currencies).

---

## ✨ Features

- 📥 **Automatic portfolio import**  
  Supports API integration, CSV/Excel uploads, and screenshot recognition.
- 🌍 **Multi-market support**  
  Kazakhstan, Russia, South Africa, Europe, and more.
- 📊 **Dividend calendar**  
  Forecasts monthly and yearly payouts.
- 🤖 **AI Insights**  
  GPT-powered analysis: detect tax/currency losses, find opportunities to increase returns.
- 🆓 **Free tier that works**  
  Free plan includes 1 portfolio and up to 50 assets.

---

## 🛠️ Tech Stack

- **Go** — backend
- **PostgreSQL** — database
- **golang-migrate** — database migrations
- **Docker + Docker Compose** — environment
- **OpenAI GPT API** — AI insights

---

## 📦 Installation

1. Clone the repo
2. Create `.env` file with database settings:

```dotenv
DB_USER=postgres
DB_PASS=postgres
DB_NAME=firetrack
DB_HOST=localhost
DB_PORT=5432
DB_SSLMODE=disable
```

3. Start containers:

```bash
make up
```

---

## ⚙️ Database Migrations

We use [golang-migrate](https://github.com/golang-migrate/migrate) to manage database migrations.

### Makefile (snippet)

```makefile
# Load .env if present
-include .env
export $(shell sed 's/=.*//' .env)

DB_URL=postgres://$(DB_USER):$(DB_PASS)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)?sslmode=$(DB_SSLMODE)
MIGRATIONS_PATH=file://migrations

migrate-up:
	migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" up

migrate-down:
	migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" down 1

migrate-reset:
	migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" down -all

migrate-up-n:
	migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" up 1

migrate-create:
	@read -p "Enter migration name: " name; \
	migrate create -ext sql -dir migrations $$name
```

### Commands

Apply all migrations:
```bash
make migrate-up
```

Rollback the last migration:
```bash
make migrate-down
```

Rollback all migrations:
```bash
make migrate-reset
```

Apply one migration step up:
```bash
make migrate-up-n
```

Create a new migration:
```bash
make migrate-create
# Enter a name, e.g. add_dividends_table
```

### Migration files format

```
migrations/{timestamp}_{name}.up.sql
migrations/{timestamp}_{name}.down.sql
```

---

## 🔮 Roadmap

- 📈 Extended dividend calendar (monthly cashflow view)
- 💡 AI advisor: rebalancing, tax optimization
- 🌍 Support for EU and Asian brokers
- 🧾 Export to Excel/Sheets/Notion
- 🏦 White-label solution for wealth managers

---

## ✅ License

MIT

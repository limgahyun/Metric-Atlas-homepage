# Deploys this consumer project (Metric-Atlas-homepage) exactly the way any
# external team would: @metric-atlas/vite and @metric-atlas/cli are both real
# devDependencies (npm install @metric-atlas/vite @metric-atlas/cli), built
# with the Vite plugin enabled, then served with `metric-atlas serve` — one
# origin for the site, the Runtime API, and the bundled Analytics Health
# Dashboard (/__metric-atlas/dashboard, see Metric-Atlas ADR-009).
#
# GA4 credentials are supplied at container start via environment variables
# (METRIC_ATLAS_GA4_PROPERTY_ID + METRIC_ATLAS_GA4_SERVICE_ACCOUNT_JSON_BASE64),
# never baked into the image.

FROM node:22-bookworm-slim

WORKDIR /app
COPY . .

RUN npm ci

RUN METRIC_ATLAS_ENABLED=true npm run build

EXPOSE 8080

CMD ["npx", "metric-atlas", "serve", "dist", "--host", "0.0.0.0", "--port", "8080"]

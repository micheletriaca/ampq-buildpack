#!/usr/bin/env bash
set -e

ROUTING_KEY="openapi.rebuild.requested"
EXCHANGE="domain.events"
SERVICE_NAME=${SERVICE_NAME:-"default-service"}

echo "📤 Publishing OpenAPI rebuild event for: $SERVICE_NAME"

PAYLOAD="{\"service\":\"$SERVICE_NAME\"}"

/app/bin/openapi-publish \
  --uri "$STACKHERO_RABBITMQ_AMQP_URL_TLS" \
  --exchange "$EXCHANGE" \
  --routing-key "$ROUTING_KEY" \
  --body "$PAYLOAD" || {
    echo "❌ Failed to publish event to RabbitMQ"
    exit 1
  }

echo "✅ Event sent to RabbitMQ"
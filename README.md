# WebhookService

# Tecnologias - Elixir, Kafka, Docker, Postgres, ApiRest, Oban, Broadway Message
Projeto base em elixir, de um servico de mensageria sincrono e assincrono que converte uma moeda para outra em três partes*
1. Um producer de mensagem usando Kafka -> Solicita o envio da mensagem via endpoint e cadastro do solicitante em base
2. Um database PostgresSQL com CRUD -> Recebe os dados de cadastros para os Webhooks de envio dos dados
3. Um Consumer das mensagens unsando Broadway -> Resgata as mensagens da fila do Kafka e envia para o Oban para agendar o envio ou enviar diretamente

# Technologies - Elixir, Kafka, Docker, Postgres, ApiRest, Oban, Broadway Message
Project based on elixir, a synchronous and asynchronous messaging service that converts one currency to another in three parts
1. A message producer using Kafka -> Requests the message to be sent via endpoint and registers the requestor on the basis
2. A PostgresSQL database with CRUD -> Receives registration data for the data sending Webhooks
3. A consumer of messages using Broadway -> retrieves messages from the Kafka queue and sends them to Oban to schedule sending or send directl


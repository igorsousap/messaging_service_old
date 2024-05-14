# WebhookService

# How to start the projetc and Use:
1. Use ASDF to install the elixir and erlang dependecies
2. Use on the terminal docker compose up to start the docker images
3. After docker is up star use the command mix ecto.create and ecto.migrate
5. Start iex with the command on the terminal: iex -S mix phx.server
6. For request the currencie to be converted need to create a token from:
  https://www.exchangerate-api.com/
7. On the postman or any http requester use this routes: 
  - POST for register User: localhost:4000/api/user and body jason request: {"endpoint": "teste.com", "event_type": "sender.message_converter","client": "teste_client"}
  - POST for send message to kafka: localhost:4000/api/convert_value and body jason request:{"endpoint": "test.com", "client": "teste", "currencie_from": "USD", "currencie_to": "BRL", "value_to_convert": 50, "schedule_at": "2024-04-20 22:00:00"} Obs.: schedule_at is optional for send message
  - OPTIONAL ENDPOINT: Update client: Needs to pass who`s client and event will be change: {"endpoint": "teste.com/new", "client": "teste", "event_type": "novo_event"} In this case the client and event_type selected will be updated and the data changes will be "endpoint". OBS.: event_type cant be change
  - OPTIONAL ENDPOINT: Get User: recives the name os the client and show all the endpoints registers for this cliente: localhost:4000/api/user/teste
7. After this the consumer will take de message and send the message for the endpoint register for the client has request the message

# Tecnologias - Elixir, Kafka, Docker, Postgres, ApiRest, Oban, Broadway Message
Projeto base em elixir, de um servico de mensageria sincrono e assincrono que converte uma moeda para outra em três partes*
1. Um producer de mensagem usando Kafka -> Solicita o envio da mensagem via endpoint e cadastro do solicitante em base
2. Um database PostgresSQL com CRUD -> Recebe os dados de cadastros para os Webhooks de envio dos dados
3. Um Consumer das mensagens unsando Broadway -> Resgata as mensagens da fila do Kafka e envia para o Oban para agendar o envio ou enviar diretamente

# Technologies - Elixir, Kafka, Docker, Postgres, ApiRest, Oban, Broadway Message
Project based on elixir, a synchronous and asynchronous messaging service that converts one currency to another in three parts
1. A message producer using Kafka -> Requests the message to be sent in a endpoint and registers the requestor on the database
2. A PostgresSQL database with CRUD -> Receives registration webhooks where select who`s the client and webhooks will receive the message
3. A consumer of messages using Broadway -> Retrieves messages from the Kafka queue and sends them to Oban to schedule sending or send directly


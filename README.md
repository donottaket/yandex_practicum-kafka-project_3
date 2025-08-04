# Модуль 4. Интеграция с внешними системами на примере Kafka Connect. Практическая работа 5. 3 ДЗ

## Структура проекта

| Компонент                              | Описание                                                                                                   |
|----------------------------------------|------------------------------------------------------------------------------------------------------------|
| [Коннекторы](confluent-hub-components) | Доступные коннекторы для Kafka Connect. Позволяют интегрировать различные источники и приемники данных.    |
| [Postgres БД](postgres)                | База данных `project3`. Таблицы: `users`, `orders`.                                                        |
| [Grafana](grafana)                     | Инструмент для визуализации и мониторинга данных. Позволяет создавать дашборды и графики на основе метрик. |
| [Prometheus](prometheus)               | Система мониторинга и алертинга. Сбор метрик с приложений и сервисов.                                      |
| [Kafka connect](kafka-connect)         | Платформа для интеграции. Подключаем коннекторы для работы с данными.                                      |
| [Consumer service](consumer)           | Сервис-консьюмер, для вывода данных в консоль.                                                             |

---

## Запускаемые контейнеры

| Контейнер       | Назначение                                         |
|-----------------|----------------------------------------------------|
| Kafka (KRaft)   | 3 контроллера + 3 брокера (Kraft режим)            |
| Kafka Connect   | Интеграция с Postgres (через Debezium)             |
| Postgres        | Источник данных (таблицы `users`, `orders`)        |
| Schema Registry | Работа с Avro-схемами                              |
| Prometheus      | Сбор метрик                                        |
| Grafana         | Дашборды по Kafka Connect                          |
| Kafka UI        | Визуальное управление Kafka                        |
| Consumer        | Spring Boot-приложение (выводит события в консоль) |

___

## Запуск

Для запуска проекта необходимо выполнить следующие шаги:

1. Запустить Docker Compose, который поднимет все необходимые контейнеры:

```bash
  docker compose up -d
```

2. Дождаться запуска всех контейнеров. Это можно сделать с помощью команды:

```bash
  docker compose logs -f
```

3. Сконфигурировать Kafka Connect:

```bash
  curl -X PUT http://localhost:8083/connectors/pg-connector/config \
  -H "Content-Type: application/json" \
  -d '{
    "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
    "database.hostname": "postgres",
    "database.port": "5432",
    "database.user": "postgres-user",
    "database.password": "postgres-password",
    "database.dbname": "project3",
    "database.server.name": "project3",
    "table.whitelist": "project3.users,project3.orders",
    "transforms": "unwrap",
    "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
    "transforms.unwrap.drop.tombstones": "false",
    "transforms.unwrap.delete.handling.mode": "rewrite",
    "topic.prefix": "project3",
    "topic.creation.enable": "true",
    "topic.creation.default.replication.factor": "-1",
    "topic.creation.default.partitions": "-1",
    "skipped.operations": "none"
  }'
```

___

## Проверка

* Kafka UI http://localhost:8080. Здесь можно просматривать топики, сообщения.

* Schema Registry http://localhost:8081/subjects. Здесь можно просматривать схемы Avro.

* Prometheus http://localhost:9090. Здесь можно просматривать метрики, собранные с коннектора.

* Grafana http://localhost:3000. Логин/пароль по умолчанию: admin / admin. Нужно импортировать дашборды
  [connect](grafana/dashboards/connect.json). Здесь можно просматривать метрики, собранные с коннектора.

* Посмотреть логи consumer сервиса, который выводит события в консоль:

```bash
  docker logs consumer
```
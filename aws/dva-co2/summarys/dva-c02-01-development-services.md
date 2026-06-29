# DVA-C02 — 01 — Development with AWS Services

> Objetivo: revisão rápida do Domain 1 da AWS Certified Developer - Associate. Use este arquivo para bater o olho antes de simulados.

Fonte-base: AWS Exam Guide DVA-C02 — Domain 1: Development with AWS Services.

---

## Peso na prova

- **Development with AWS Services: 32%** do conteúdo pontuado.
- É o domínio mais pesado.
- Foco: escrever código que usa serviços AWS, integrar aplicações, lidar com eventos, mensageria, Lambda e data stores.

---

## Mental model da prova

A prova geralmente pergunta:

- “Qual serviço/configuração resolve esse cenário?”
- “Como deixar essa aplicação mais resiliente?”
- “Como integrar serviço A com serviço B?”
- “Como reduzir acoplamento?”
- “Como evitar perda/duplicação de mensagens?”
- “Como melhorar performance de Lambda/DynamoDB?”

---

# 1. Arquitetura de aplicações AWS

## Event-driven

- Componentes se comunicam por eventos.
- Produtor não precisa saber exatamente quem consome.
- Serviços típicos:
  - **EventBridge**: roteamento de eventos entre aplicações/SaaS/serviços AWS.
  - **SNS**: fanout/pub-sub.
  - **SQS**: filas e desacoplamento.
  - **Lambda**: execução reativa a eventos.

### Quando usar

- Quando você quer baixo acoplamento.
- Quando múltiplos consumidores podem reagir ao mesmo evento.
- Quando o fluxo pode ser assíncrono.

### Palavras-chave de prova

- decouple
- asynchronous
- event bus
- fanout
- retry
- DLQ
- at-least-once delivery

---

## Microservices

- Aplicação dividida em serviços menores.
- Cada serviço pode ter seu próprio deploy, banco e ciclo de vida.
- Comunicação pode ser síncrona ou assíncrona.

### Riscos

- Mais complexidade operacional.
- Mais necessidade de observabilidade.
- Falhas parciais são comuns.

### Serviços comuns

- API Gateway
- Lambda
- ECS/Fargate
- EventBridge
- SQS/SNS
- DynamoDB
- CloudWatch/X-Ray

---

## Monolith

- Um único deploy contém várias responsabilidades.
- Mais simples de operar no começo.
- Pode virar gargalo de escala/deploy.

---

## Choreography vs Orchestration

### Choreography

- Cada serviço reage a eventos sem um controlador central.
- Exemplo: pedido criado → EventBridge → billing, inventory e notification reagem.
- Bom para baixo acoplamento.
- Pode ser difícil visualizar o fluxo inteiro.

### Orchestration

- Um serviço central coordena os passos.
- Exemplo: Step Functions controla pagamento → estoque → nota fiscal → notificação.
- Bom quando a ordem importa e há compensações/retries explícitos.

---

## Fanout

- Um evento precisa ser enviado para múltiplos consumidores.
- Padrão comum: **SNS topic → múltiplas SQS queues**.
- Cada consumidor tem sua própria fila.
- Evita que um consumidor lento afete os outros.

---

# 2. Stateless vs Stateful

## Stateless

- A aplicação não depende de estado local entre requisições.
- Estado fica fora: banco, cache, S3, DynamoDB, ElastiCache, session store.
- Facilita escala horizontal.
- É preferível em Lambda, containers e autoscaling.

## Stateful

- A aplicação depende de estado local/memória/disco.
- Mais difícil escalar e recuperar.
- Pode exigir sticky sessions ou armazenamento compartilhado.

### Na prova

Se a questão fala em escalar horizontalmente, alta disponibilidade ou múltiplas instâncias, geralmente a resposta envolve **stateless + externalizar estado**.

---

# 3. Tightly coupled vs Loosely coupled

## Tightly coupled

- Serviço A depende diretamente de B.
- Falha em B impacta A imediatamente.
- Exemplo: API síncrona direta para um serviço instável.

## Loosely coupled

- Serviços se comunicam via fila, evento ou contrato bem definido.
- Falhas ficam isoladas.
- Exemplo: API recebe pedido e publica em SQS; worker processa depois.

### Serviços para desacoplar

- SQS
- SNS
- EventBridge
- Step Functions
- Kinesis

---

# 4. Synchronous vs Asynchronous

## Synchronous

- Cliente espera resposta imediata.
- Exemplo: API Gateway → Lambda → DynamoDB.
- Bom para leitura/validação/resposta rápida.
- Ruim para tarefas longas.

## Asynchronous

- Cliente dispara trabalho e não espera o processamento completo.
- Exemplo: API Gateway → SQS → Lambda worker.
- Melhor para resiliência, retries e picos de tráfego.

### Na prova

Se aparece:

- processamento demorado
- picos de tráfego
- necessidade de retry
- falha de serviço downstream
- desacoplamento

Pense em **SQS/EventBridge/SNS + DLQ**.

---

# 5. Resiliência em código

## Patterns importantes

- **Retries com backoff exponencial**: tentar de novo aumentando o intervalo.
- **Jitter**: aleatoriedade para evitar thundering herd.
- **Circuit breaker**: parar chamadas temporariamente para serviço degradado.
- **Timeouts explícitos**: não deixar chamadas penduradas.
- **Idempotência**: repetir a operação sem causar efeito duplicado.
- **DLQ**: guardar mensagens que falharam repetidamente.

## Idempotência

- Essencial em sistemas event-driven.
- AWS muitas vezes entrega eventos/mensagens com semântica **at-least-once**.
- A mesma mensagem pode ser processada mais de uma vez.

### Técnicas

- Usar `requestId`, `eventId`, `idempotencyKey`.
- Salvar chave processada em DynamoDB.
- Usar conditional write.
- Evitar efeitos colaterais duplicados.

---

# 6. APIs na AWS

## API Gateway

### Conceitos

- Expõe APIs HTTP/REST/WebSocket.
- Integra com Lambda, HTTP backend, AWS services.
- Pode fazer request/response transformations.
- Pode validar payloads.
- Pode alterar status codes e headers.

### Features cobradas

- Stages: dev/test/prod.
- Stage variables.
- Custom domains.
- Authorizers.
- Throttling.
- Caching.
- Mapping templates.
- Lambda proxy integration.
- Usage plans/API keys.

### Lambda proxy integration

- API Gateway passa quase tudo para a Lambda.
- Lambda retorna objeto com `statusCode`, `headers`, `body`.
- Mais simples para dev.

### Non-proxy integration

- API Gateway pode transformar request/response.
- Mais controle no Gateway.

---

# 7. SDKs e APIs AWS

## O que saber

- Usar AWS SDK para chamar serviços.
- Credenciais vêm de:
  - IAM Role em Lambda/ECS/EC2.
  - environment/profile local.
  - STS AssumeRole.
- Não hardcodar access key/secret key.

## Região

- SDK precisa saber a região.
- Erros comuns vêm de recurso em região diferente.

## Paginação

Muitas APIs AWS retornam resultados paginados:

- `NextToken`
- `LastEvaluatedKey`
- `ContinuationToken`

Na prova, se precisa listar muitos itens, lembre de tratar paginação.

---

# 8. Messaging services

## SQS Standard Queue

- Alta escala.
- Entrega pelo menos uma vez.
- Pode entregar mensagens fora de ordem.
- Mensagem pode ser duplicada.
- Use idempotência.

### Configurações importantes

- Visibility timeout.
- Message retention.
- Delay queue.
- Long polling.
- DLQ + redrive policy.

## SQS FIFO Queue

- Ordem garantida por `MessageGroupId`.
- Exatamente uma vez no contexto de deduplicação.
- Menor throughput que Standard.
- Usa `MessageDeduplicationId`.

## Visibility timeout

- Tempo em que a mensagem fica invisível depois de ser recebida.
- Se o worker não deletar a mensagem nesse tempo, ela volta para a fila.
- Deve ser maior que o tempo esperado de processamento.

## Long polling

- Reduz chamadas vazias.
- Usa `WaitTimeSeconds`.
- Mais eficiente e barato.

## DLQ

- Guarda mensagens que falharam várias vezes.
- Configuração-chave: `maxReceiveCount`.
- Ajuda troubleshooting sem perder mensagem.

---

## SNS

- Pub/sub.
- Fanout para múltiplos subscribers.
- Pode entregar para SQS, Lambda, HTTP/S, email, SMS etc.
- Pode usar filter policies para entregar apenas mensagens relevantes.

### SNS + SQS

- Padrão clássico de fanout resiliente.
- Cada consumidor recebe sua fila própria.

---

## EventBridge

- Event bus para eventos de aplicações, AWS services e SaaS.
- Regras roteiam eventos com event patterns.
- Bom para arquitetura orientada a eventos.
- Suporta schema registry e archive/replay em alguns cenários.

### Quando preferir EventBridge

- Roteamento por padrão de evento.
- Integração entre domínios/sistemas.
- Eventos de negócio.
- Baixo acoplamento.

### Quando preferir SQS

- Preciso de fila explícita.
- Controle de consumo.
- Worker processa uma mensagem por vez/lote.
- Buffer contra picos.

---

## Kinesis

- Streaming de dados em tempo quase real.
- Dados organizados em shards.
- Ordem garantida por partition key dentro do shard.
- Usado para logs, analytics, eventos em alta escala.

### Conceitos

- Producer envia records.
- Consumer lê records.
- Shard define capacidade.
- Partition key decide shard.

---

# 9. AWS Lambda

## Configurações principais

- Runtime.
- Handler.
- Memory.
- Timeout.
- Environment variables.
- Layers.
- Extensions.
- Concurrency.
- Reserved concurrency.
- Provisioned concurrency.
- Triggers.
- Destinations.
- DLQ.

---

## Lambda + VPC

Lambda só precisa estar em VPC quando precisa acessar recursos privados, como:

- RDS privado.
- ElastiCache privado.
- serviços internos em subnets privadas.

### Atenção

- Lambda em VPC precisa de NAT Gateway ou VPC endpoints para acessar internet/serviços públicos.
- Security Groups e subnets importam.
- Problemas comuns: timeout por falta de rota/NAT/SG.

---

## Memory e CPU

- Aumentar memória também aumenta CPU e network throughput.
- Pode reduzir duração e custo total.
- Use testes/Power Tuning para achar ponto ótimo.

---

## Cold start

- Primeira execução ou execução após inatividade pode demorar mais.
- Mitigações:
  - Provisioned concurrency.
  - reduzir package size.
  - inicializar clientes fora do handler.
  - evitar dependências pesadas.

---

## Handler best practices

- Inicialize SDK clients fora do handler para reutilização.
- Use timeout menor que o timeout externo quando possível.
- Trate erros explicitamente.
- Logue contexto suficiente.
- Não guarde estado crítico em `/tmp` ou memória entre execuções.

---

## Lambda Destinations vs DLQ

### DLQ

- Para falhas em invocações assíncronas.
- Envia evento falho para SQS/SNS.
- Configuração: parâmetro `DeadLetterConfig` apontando para o **ARN** de uma fila SQS ou tópico SNS.

### Destinations

- Mais rico que DLQ.
- Pode enviar resultado de sucesso ou falha.
- Destinos: SQS, SNS, Lambda, EventBridge.

---

## Event source mapping

Usado quando Lambda consome de:

- SQS
- DynamoDB Streams
- Kinesis

Conceitos:

- Batch size.
- Batch window.
- Partial batch response.
- Retry behavior.
- Bisect batch on error para streams.

---

# 10. Data stores

## DynamoDB

### Conceitos centrais

- Table.
- Item.
- Attribute.
- Partition key.
- Sort key.
- Primary key.
- GSI.
- LSI.
- Query.
- Scan.

---

## Partition key

- Decide distribuição física dos dados.
- Alta cardinalidade = muitos valores distintos.
- Boa partition key evita hot partition.

### Boa partition key

- Distribui leitura/escrita.
- Evita todos os acessos no mesmo valor.
- Exemplo ruim: `status = OPEN` se quase tudo está OPEN.
- Exemplo melhor: `customerId`, `orderId`, `tenantId#entityId` dependendo do padrão.

---

## Query vs Scan

### Query

- Busca por partition key.
- Pode usar sort key condition.
- Eficiente.
- Preferido na prova.

### Scan

- Lê a tabela inteira ou índice inteiro.
- Caro e lento.
- Evitar em workloads grandes.

Se a questão fala em performance/custo, geralmente **trocar Scan por Query/GSI** é a resposta.

---

## Projection Expression vs Filter Expression

### Projection Expression

- Define **quais atributos** retornar em `GetItem`/`Query`/`Scan`.
- É o "select campo1, campo2" em vez de "select *".
- Reduz payload, não reduz custo de leitura do item inteiro.

### Filter Expression

- Define **quais itens** retornar (é o "WHERE").
- Aplicado **depois** da leitura: você paga a capacidade dos itens lidos, mesmo os filtrados fora.
- Por isso não substitui uma boa key condition / GSI.

---

## Consistency

### Eventually consistent

- Padrão em muitas leituras DynamoDB.
- Mais barato/rápido.
- Pode retornar dado antigo por curto período.

### Strongly consistent

- Retorna escrita mais recente confirmada.
- Pode ter maior custo/limitações.
- Não disponível para GSI.

---

## GSI vs LSI

### GSI — Global Secondary Index

- Partition key e sort key diferentes da tabela.
- Pode ser criado depois.
- Eventual consistency.
- Usado para novos access patterns.

### LSI — Local Secondary Index

- Mesma partition key da tabela.
- Sort key diferente.
- Precisa ser criado junto com a tabela.
- Permite strong consistency.

---

## DynamoDB Streams

- Captura mudanças em itens da tabela.
- Pode acionar Lambda.
- Usado para replicação, auditoria, projeções, event-driven.
- Retenção do stream: **24 horas**.
- Pode integrar com Lambda/SNS para sistemas reativos a mudanças.

### StreamViewType (qual imagem do item vai no record)

- `KEYS_ONLY`: só as chaves do item alterado.
- `NEW_IMAGE`: item **depois** da mudança.
- `OLD_IMAGE`: item **antes** da mudança.
- `NEW_AND_OLD_IMAGES`: antes **e** depois (para diff/auditoria).

---

## TTL

- Expira itens automaticamente.
- Útil para sessões, tokens, dados temporários.
- Exclusão não é imediata em tempo real.

---

## Conditional writes

- Escreve apenas se condição for verdadeira.
- Útil para idempotência, locks, evitar sobrescrita.
- Exemplo: salvar só se `attribute_not_exists(id)`.

---

# 11. Caching

## ElastiCache

- Redis/Memcached gerenciado.
- Usado para cache de aplicação, sessão, rate limiting, rankings etc.
- Reduz latência e carga no banco.

## API Gateway caching

- Cache por stage/method.
- Pode considerar parâmetros/header/query string.
- Útil para endpoints de leitura.
- **Invalidar cache**: cliente manda o header `Cache-Control: max-age=0` na request (precisa de permissão `InvalidateCache` na policy).

## DynamoDB Accelerator (DAX)

- Camada de cache **in-memory na frente da tabela DynamoDB**.
- Microssegundos de latência para leitura pesada/repetida.
- Menos overhead de código que ElastiCache (é DynamoDB-aware: mesma API).
- Use quando a questão fala em "acelerar leituras do DynamoDB" sem reescrever a aplicação.

## CloudFront

- CDN/cache na borda.
- Bom para conteúdo estático e APIs públicas.
- Cache behavior pode variar por headers/query/cookies.

---

# 12. Serviços especializados

## OpenSearch

- Busca textual, logs, analytics.
- Use quando precisa de busca full-text, ranking, filtros complexos.
- Não substitui DynamoDB para key-value de baixa latência.

## S3

- Object storage.
- Bom para arquivos, assets, logs, backups.
- Versioning.
- Lifecycle policies.
- Presigned URLs.
- Event notifications.

### Detalhes que o Dojo cobra

- **Transfer Acceleration**: acelera upload/download em **longas distâncias** (usa edge locations do CloudFront). Red flag: "usuários no mundo todo com upload lento".
- **Event Notifications** podem disparar: SQS, Lambda, SNS e **EventBridge**. Ex.: evento `s3:ObjectCreated:Put`.
- **CORS**: `<MaxAgeSeconds>3600</MaxAgeSeconds>` = browser cacheia o preflight OPTIONS por 1h.
- **Encryption header**: `x-amz-server-side-encryption: AES256` → SSE-S3. Para SSE-KMS o valor é `aws:kms`.

## RDS/Aurora

- Relacional.
- Transações SQL.
- Joins.
- Schema relacional.

## EC2 — Instance Metadata

- Endpoint interno: `http://169.254.169.254/latest/meta-data/`.
- Retorna dados da instância (IP local, IAM role, AZ, instance-id etc.) sem credenciais.
- Use para descobrir IP/região/role de dentro da própria instância.

---

# Checklist de domínio 1

Você deve conseguir explicar rapidamente:

- [ ] Quando usar SQS vs SNS vs EventBridge vs Kinesis.
- [ ] Diferença entre Standard e FIFO queue.
- [ ] Visibility timeout e DLQ.
- [ ] Como evitar duplicação com idempotência.
- [ ] Lambda timeout, memory, concurrency e cold start.
- [ ] Lambda em VPC e necessidade de NAT/VPC endpoints.
- [ ] API Gateway stages, authorizers, throttling e mapping.
- [ ] DynamoDB partition key, sort key, GSI, LSI.
- [ ] Query vs Scan.
- [ ] Strong vs eventual consistency.
- [ ] DynamoDB Streams e TTL.
- [ ] Caching com ElastiCache, CloudFront e API Gateway.

---

# Red flags de prova

- “Processamento demorado após request HTTP” → SQS + worker/Lambda.
- “Múltiplos consumidores para o mesmo evento” → SNS fanout ou EventBridge.
- “Roteamento baseado no conteúdo do evento” → EventBridge rules ou SNS filter policies.
- “Mensagens duplicadas” → idempotência.
- “Worker processa mensagem mas ela volta para fila” → visibility timeout curto.
- “DynamoDB lento/caro” → evitar Scan; usar Query/GSI; melhorar partition key.
- “Lambda precisa acessar RDS privado” → Lambda na VPC + SG/subnet.
- “Lambda na VPC perdeu internet” → falta NAT Gateway ou VPC endpoint.


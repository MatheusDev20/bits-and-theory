# DVA-C02 — 03 — Troubleshooting, Optimization e Checklist Final

> Objetivo: revisão rápida do Domain 4 + checklist geral para reta final da AWS Certified Developer - Associate.

Fonte-base: AWS Exam Guide DVA-C02 — Domain 4: Troubleshooting and Optimization.

---

## Peso na prova

- **Troubleshooting and Optimization: 18%**.
- Apesar de ser o menor domínio, ele aparece misturado nos outros.
- Muitas questões de Lambda, API Gateway, SQS, DynamoDB e deploy são, na prática, troubleshooting.

---

## Mental model da prova

A prova pergunta:

- “Onde olhar para descobrir a causa?”
- “Qual métrica/log/tracing usar?”
- “Como melhorar performance/custo?”
- “Como lidar com throttling, timeout, retry e gargalo?”
- “Como instrumentar a aplicação?”

---

# 1. Logging, Monitoring e Observability

## Logging

- Registro de eventos que aconteceram.
- Exemplo: erro, requestId, payload parcial, status, tenantId, duration.
- Serviço principal: **CloudWatch Logs**.

## Monitoring

- Acompanhar métricas e estado do sistema.
- Exemplo: erros, latência, invocações, throttles.
- Serviço principal: **CloudWatch Metrics/Alarms/Dashboards**.

## Observability

- Capacidade de entender o estado interno do sistema a partir de logs, métricas e traces.
- Serviços: CloudWatch, X-Ray, ServiceLens, Logs Insights.

---

# 2. CloudWatch Logs

## O que saber

- Lambda envia logs para CloudWatch Logs.
- Logs ficam em log groups e log streams.
- Use correlation IDs/request IDs para rastrear fluxo.
- Evite logar segredo/PII.

## Boas práticas

- Log estruturado em JSON.
- Incluir `requestId`, `userId/tenantId` quando seguro, `operation`, `status`, `durationMs`.
- Separar info/warn/error.

---

# 3. CloudWatch Logs Insights

## Para que serve

- Consultar logs com linguagem de query.
- Ajuda a achar padrões, erros, latência, requests específicos.

## Quando a prova sugere

- “Find relevant data in logs.”
- “Query application logs.”
- “Identify bottleneck from logs.”

---

# 4. CloudWatch Metrics

## Métricas importantes de Lambda

- Invocations.
- Errors.
- Duration.
- Throttles.
- ConcurrentExecutions.
- IteratorAge para streams.
- DeadLetterErrors.

## Métricas importantes de API Gateway

- 4XXError.
- 5XXError.
- Latency.
- IntegrationLatency.
- Count.
- CacheHitCount/CacheMissCount.

## Métricas importantes de SQS

- ApproximateNumberOfMessagesVisible.
- ApproximateNumberOfMessagesNotVisible.
- ApproximateAgeOfOldestMessage.
- NumberOfMessagesSent/Received/Deleted.

## Métricas importantes de DynamoDB

- ConsumedReadCapacityUnits.
- ConsumedWriteCapacityUnits.
- ThrottledRequests.
- SuccessfulRequestLatency.
- SystemErrors/UserErrors.

---

# 5. CloudWatch Alarms

## Para que serve

- Alarmar quando métrica cruza limite.
- Pode notificar SNS.
- Pode acionar rollback em CodeDeploy.

## Exemplos de alarmes úteis

- Lambda Errors > 0.
- Lambda Throttles > 0.
- API Gateway 5XX alto.
- SQS AgeOfOldestMessage alto.
- DynamoDB throttling.

---

# 6. AWS X-Ray

## Para que serve

- Distributed tracing.
- Mostra chamadas entre serviços.
- Ajuda a achar gargalo e falha em sistemas distribuídos.

## Conceitos

- Trace.
- Segment.
- Subsegment.
- Annotation.
- Metadata.
- Service map.

## Annotation vs Metadata

### Annotation

- Indexável/filtrável.
- Use para coisas como `tenantId`, `orderId`, `route`, `environment` quando apropriado.

### Metadata

- Não indexável.
- Use para contexto adicional.

---

# 7. Custom metrics

## Quando usar

- Métricas de negócio ou aplicação que a AWS não fornece pronta.
- Exemplo:
  - `OrdersCreated`.
  - `PaymentFailures`.
  - `CheckoutLatency`.
  - `ExternalApiTimeouts`.

## EMF — Embedded Metric Format

- Formato que permite escrever logs estruturados que viram métricas no CloudWatch.
- Útil para emitir métricas customizadas de dentro da aplicação.

---

# 8. Health checks e readiness probes

## Health check

- Verifica se serviço está vivo.
- Exemplo: endpoint `/health`.

## Readiness

- Verifica se serviço está pronto para receber tráfego.
- Exemplo: dependências carregadas, conexão com banco ok.

## Na prova

Se há deploy/containers e tráfego indo para instância ainda não pronta, pense em readiness/health checks.

---

# 9. Troubleshooting Lambda

## Timeout

Possíveis causas:

- Timeout configurado baixo.
- Chamada externa lenta.
- Lambda em VPC sem NAT/VPC endpoint.
- Security group bloqueando.
- DNS/rede.
- Cold start pesado.

Ações:

- Ver CloudWatch Logs.
- Aumentar timeout se necessário.
- Conferir VPC route table/NAT/SG.
- Definir timeout em chamadas HTTP/SDK.
- Usar X-Ray.

---

## Throttling

Causas:

- Concurrency limite atingido.
- Reserved concurrency baixo.
- Pico de eventos.

Ações:

- Ver ConcurrentExecutions e Throttles.
- Ajustar reserved concurrency.
- Usar SQS para buffer.
- Solicitar quota se necessário.

---

## Erros com SQS event source

Cenários:

- Mensagem volta para fila → visibility timeout menor que processamento.
- Mensagem vai para DLQ → falhou mais vezes que `maxReceiveCount`.
- Um item ruim falha batch inteiro → usar partial batch response.
- Duplicidade → idempotência.

---

## IteratorAge alto em Kinesis/DynamoDB Streams

Significa que Lambda está atrasada no processamento de stream.

Possíveis causas:

- Pouca concorrência/capacidade.
- Função lenta.
- Erros/retries bloqueando progresso.
- Batch size inadequado.

Ações:

- Otimizar função.
- Ajustar batch.
- Aumentar paralelismo quando aplicável.
- Ver erros e retries.

---

# 10. Troubleshooting API Gateway

## 4XX

Geralmente problema do cliente/autorização/validação.

Exemplos:

- Missing Authentication Token.
- Unauthorized/Forbidden.
- Payload inválido.
- Rota/método errado.
- API key ausente quando exigida.

## 5XX

Geralmente problema na integração/backend.

Exemplos:

- Lambda retornou formato inválido em proxy integration.
- Lambda deu erro/timeout.
- Permissão para API Gateway invocar Lambda ausente.
- Backend indisponível.

## Latency vs IntegrationLatency

- Latency: tempo total no API Gateway.
- IntegrationLatency: tempo gasto na integração/backend.

Se IntegrationLatency está alta, o gargalo provavelmente está no backend.

---

# 11. Troubleshooting DynamoDB

## Throttling

Causas:

- Capacidade insuficiente.
- Hot partition.
- Access pattern ruim.
- Scan pesado.

Ações:

- Usar Query em vez de Scan.
- Melhorar partition key.
- Usar GSI adequado.
- On-demand capacity se tráfego imprevisível.
- Exponential backoff.

---

## Query não atende access pattern

Possíveis soluções:

- Criar GSI.
- Ajustar chave composta.
- Denormalizar dados.
- Modelar com base nas queries reais.

---

# 12. Troubleshooting S3

## AccessDenied

Possíveis causas:

- IAM policy não permite.
- Bucket policy nega.
- KMS key policy não permite decrypt.
- Object ownership/ACL em cenários legados.
- Block Public Access.

## Presigned URL

- Dá acesso temporário a objeto.
- Permissão depende de quem gera a URL.
- Expira depois de um tempo.

---

# 13. Otimização de performance

## Lambda

- Aumentar memória pode reduzir duração.
- Reutilizar clients fora do handler.
- Reduzir package size.
- Usar provisioned concurrency para cold start sensível.
- Usar SQS para absorver picos.

## DynamoDB

- Query > Scan.
- Boa partition key.
- GSI para access pattern.
- DAX/cache para leitura pesada quando aplicável.
- Batch operations quando fizer sentido.

## API Gateway/CloudFront

- Cache para respostas de leitura.
- CloudFront para reduzir latência global.
- Throttling para proteger backend.

## SQS/SNS

- Long polling em SQS.
- Batch receive/delete.
- Filter policies para reduzir entregas desnecessárias.

---

# 14. Otimização de custo

## Lambda

- Ajustar memória/duração.
- Evitar execução desnecessária.
- Usar timeout correto.

## CloudWatch Logs

- Controlar retenção de logs.
- Evitar logs excessivos.

## DynamoDB

- On-demand para tráfego imprevisível.
- Provisioned com autoscaling para tráfego previsível.
- Evitar Scan.

## S3

- Lifecycle policies.
- Storage classes adequadas.

---

# 15. Subscription filter policies

## SNS filter policy

- Filtra mensagens por atributos.
- Evita entregar mensagem para consumidor que não precisa dela.
- Reduz processamento e custo.

Exemplo mental:

- Topic recebe todos os eventos de pedido.
- Fila de nota fiscal só recebe eventos `status = PAID`.

---

# 16. Caching baseado em headers

## CloudFront cache key

Pode variar cache por:

- Headers.
- Cookies.
- Query strings.

## Atenção

- Quanto mais variações, menor cache hit ratio.
- Só inclua no cache key o que realmente muda a resposta.

---

# 17. Checklist final por serviço

## Lambda

- [ ] Execution role.
- [ ] Timeout.
- [ ] Memory/CPU.
- [ ] Concurrency/reserved/provisioned.
- [ ] Env vars.
- [ ] Layers.
- [ ] DLQ/Destinations.
- [ ] VPC/NAT/VPC endpoints.
- [ ] CloudWatch Logs.
- [ ] X-Ray.
- [ ] Event source mapping.
- [ ] Partial batch response para SQS.

## API Gateway

- [ ] Stages.
- [ ] Authorizers.
- [ ] Lambda proxy response format.
- [ ] Mapping templates.
- [ ] Throttling.
- [ ] Caching.
- [ ] Custom domain.
- [ ] 4XX vs 5XX.
- [ ] Latency vs IntegrationLatency.

## DynamoDB

- [ ] Partition key.
- [ ] Sort key.
- [ ] Query vs Scan.
- [ ] GSI vs LSI.
- [ ] Strong vs eventual consistency.
- [ ] TTL.
- [ ] Streams.
- [ ] Conditional writes.
- [ ] Hot partition.
- [ ] On-demand vs provisioned.

## SQS

- [ ] Standard vs FIFO.
- [ ] Visibility timeout.
- [ ] DLQ/redrive.
- [ ] Long polling.
- [ ] Delay queue.
- [ ] Batch processing.
- [ ] Idempotência.

## SNS/EventBridge

- [ ] SNS para pub-sub/fanout.
- [ ] SNS filter policies.
- [ ] EventBridge para event bus/rules/patterns.
- [ ] EventBridge para integração SaaS/AWS/app events.

## Security

- [ ] IAM least privilege.
- [ ] Role vs user.
- [ ] Resource policy vs identity policy.
- [ ] Trust policy.
- [ ] KMS key policy.
- [ ] Secrets Manager/SSM.
- [ ] Cognito User Pool vs Identity Pool.

## Deployment

- [ ] SAM.
- [ ] CloudFormation.
- [ ] CodeBuild.
- [ ] CodeDeploy.
- [ ] CodePipeline.
- [ ] Lambda versions/aliases.
- [ ] Canary/blue-green/rolling/all-at-once.
- [ ] Rollback com alarms.

---

# 18. Mapa de decisão rápido

## Preciso desacoplar processamento

- Use SQS.

## Preciso publicar para vários consumidores

- Use SNS fanout ou EventBridge.

## Preciso rotear eventos por conteúdo

- Use EventBridge rules ou SNS filter policies.

## Preciso processar stream em tempo quase real

- Use Kinesis ou DynamoDB Streams.

## Preciso login de usuário final

- Use Cognito User Pool.

## Preciso credenciais AWS temporárias para usuário federado

- Use Cognito Identity Pool ou STS.

## Preciso guardar segredo

- Use Secrets Manager ou SSM Parameter Store SecureString.

## Preciso deploy gradual de Lambda

- Use Lambda versions + aliases + CodeDeploy canary/linear.

## Preciso rollback automático

- Use CodeDeploy + CloudWatch alarms.

## Preciso investigar latência entre serviços

- Use X-Ray.

## Preciso consultar logs

- Use CloudWatch Logs Insights.

## Preciso métrica de negócio

- Use custom metrics/EMF.

---

# 19. Plano de revisão de 3 dias

## Dia 1 — Development Services

Prioridade:

1. Lambda.
2. API Gateway.
3. DynamoDB.
4. SQS/SNS/EventBridge.
5. Kinesis/Streams.
6. Caching.

Meta:

- Conseguir explicar os red flags do arquivo 01.
- Fazer questões focadas em Lambda, DynamoDB e mensageria.

---

## Dia 2 — Security + Deployment

Prioridade:

1. IAM roles/policies/trust policy.
2. Cognito.
3. KMS/encryption.
4. Secrets Manager/SSM.
5. SAM/CloudFormation.
6. CodeBuild/CodeDeploy/CodePipeline.
7. Lambda versions/aliases/deployment strategies.

Meta:

- Entender bem as diferenças: role vs policy, User Pool vs Identity Pool, SSE-KMS vs SSE-S3, alias vs version, canary vs blue/green.

---

## Dia 3 — Simulados + Correção

Prioridade:

1. Fazer 1 simulado completo.
2. Corrigir todas as erradas.
3. Revisar este arquivo 03.
4. Fazer outro simulado ou bloco de questões fracas.
5. Repassar mapas de decisão.

Critério prático:

- 80%+ em simulado: bom sinal.
- 70–79%: possível, mas revise lacunas.
- 60–69%: arriscado.
- Abaixo de 60%: melhor remarcar se possível.

---

# 20. Pegadinhas comuns

- Lambda em VPC sem NAT não acessa internet pública.
- AccessDenied com KMS pode ser key policy, não só IAM policy.
- SQS Standard pode duplicar mensagens.
- FIFO exige MessageGroupId.
- Visibility timeout curto causa reprocessamento.
- DynamoDB Scan é quase sempre má ideia em grande escala.
- GSI é eventualmente consistente.
- LSI precisa ser criado com a tabela.
- API Gateway 5XX pode ser formato inválido retornado pela Lambda.
- IntegrationLatency alta aponta backend lento.
- Secrets não devem ir hardcoded nem em logs.
- Lambda version é imutável; alias é ponteiro mutável.
- Canary é ideal para liberar pouco tráfego primeiro.
- CloudFormation rollback ajuda recuperar stack após falha.
- Explicit Deny vence Allow.
- Para cross-account, precisa permissão de assumir + trust policy.

---

# 21. Última revisão antes da prova

Consiga responder sem olhar:

- [ ] SQS vs SNS vs EventBridge.
- [ ] Standard queue vs FIFO queue.
- [ ] Visibility timeout vs message retention.
- [ ] Lambda DLQ vs Destinations.
- [ ] Reserved concurrency vs provisioned concurrency.
- [ ] Cold start: causas e mitigação.
- [ ] DynamoDB Query vs Scan.
- [ ] GSI vs LSI.
- [ ] Strong vs eventual consistency.
- [ ] IAM identity policy vs resource policy.
- [ ] Trust policy e AssumeRole.
- [ ] Cognito User Pool vs Identity Pool.
- [ ] Secrets Manager vs SSM Parameter Store.
- [ ] SSE-S3 vs SSE-KMS vs client-side encryption.
- [ ] Lambda zip vs container image vs layer.
- [ ] Lambda version vs alias.
- [ ] Canary vs blue/green vs rolling.
- [ ] CloudWatch Logs vs Metrics vs Alarms vs X-Ray.
- [ ] API Gateway 4XX vs 5XX.
- [ ] Latency vs IntegrationLatency.


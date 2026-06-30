# AWS Troubleshooting — Guia pragmático para Developer Associate

Objetivo: bater o olho em um erro/cenário e lembrar **qual serviço olhar**, **causas prováveis** e **resposta comum em prova**.

---

## Mapa mental rápido

Quando a questão falar de:

| Sintoma / necessidade | Pense primeiro em |
|---|---|
| Permissão negada | IAM Policy, IAM Role, Resource Policy, Trust Policy |
| Lambda não executa | Trigger, IAM Role, timeout, VPC, logs no CloudWatch |
| API retorna 4xx/5xx | API Gateway, Lambda, integração, authorizer, CORS |
| Serviço não acessa outro serviço | IAM Role + policy correta |
| Segredo/API key | Secrets Manager ou SSM Parameter Store |
| Configuração não secreta | SSM Parameter Store |
| Desacoplar processamento | SQS |
| Vários consumidores recebem a mesma mensagem | SNS fanout |
| Eventos entre serviços/SaaS/agendamento | EventBridge |
| Retentativas e mensagens falhando | SQS DLQ / Lambda retry / EventBridge retry |
| Logs | CloudWatch Logs |
| Métricas e alarmes | CloudWatch Metrics/Alarms |
| Tracing distribuído | X-Ray |
| Deploy canary/blue-green | CodeDeploy |
| CI/CD | CodePipeline, CodeBuild, CodeDeploy |
| Baixa latência NoSQL serverless | DynamoDB |
| Arquivos/objetos/site estático | S3 |
| CDN/cache global | CloudFront |
| Login de usuários finais | Cognito |

---

# 1. IAM / Permissões

## Sintoma

- `AccessDenied`
- `UnauthorizedOperation`
- `not authorized to perform`
- Lambda não consegue acessar DynamoDB/S3/SQS/etc.
- API Gateway/Lambda não consegue assumir role

## Onde olhar

1. IAM policy anexada à role/usuário
2. Resource policy do recurso, se existir
3. Trust policy da role
4. Região/conta correta
5. ARN correto

## Causas comuns

### A role não tem permissão para a ação

Exemplo: Lambda precisa gravar no DynamoDB.

Precisa de algo como:

```json
{
  "Effect": "Allow",
  "Action": ["dynamodb:PutItem"],
  "Resource": "arn:aws:dynamodb:REGION:ACCOUNT_ID:table/TABLE_NAME"
}
```

### A trust policy está errada

Para Lambda assumir uma role, a trust policy precisa permitir:

```json
{
  "Effect": "Allow",
  "Principal": {
    "Service": "lambda.amazonaws.com"
  },
  "Action": "sts:AssumeRole"
}
```

### Cross-account assume role

Conta A quer assumir role na Conta B.

Precisa de duas coisas:

1. Na Conta A: permissão para `sts:AssumeRole`
2. Na Conta B: trust policy confiando na Conta A / role da Conta A

## Resposta comum em prova

- Use **IAM Role**, não access keys hardcoded.
- Aplique **least privilege**.
- Para Lambda/ECS/EC2 acessar AWS services, use role associada ao serviço.

---

# 2. Lambda

## Sintoma

- Lambda não roda
- Lambda dá timeout
- Lambda não acessa internet
- Lambda não acessa banco privado
- Lambda não aparece sendo chamada
- Lambda falha ao processar eventos

## Onde olhar

1. CloudWatch Logs
2. Trigger configurado
3. IAM execution role
4. Timeout/memória
5. VPC/subnets/security groups
6. DLQ / retry behavior

## Causas comuns

### Lambda não foi chamada

Verifique:

- Trigger ativo?
- API Gateway integrado corretamente?
- EventBridge rule habilitada?
- SQS está configurado como event source?

### Lambda foi chamada, mas falhou

Verifique:

- CloudWatch Logs
- Permissões da execution role
- Variáveis de ambiente
- Timeout
- Erro no código

### Lambda dentro de VPC sem internet

Lambda em subnet privada **não tem internet automaticamente**.

Para acessar internet:

- Subnet privada
- Route table apontando para NAT Gateway
- NAT Gateway em subnet pública
- Internet Gateway na VPC

### Lambda precisa acessar RDS privado

Coloque a Lambda na mesma VPC/subnets apropriadas e configure security groups:

- SG da Lambda permitindo saída
- SG do RDS permitindo entrada a partir do SG da Lambda

### Lambda com SQS processando mensagem repetidamente

Possíveis causas:

- Lambda retorna erro
- Mensagem volta para fila depois do visibility timeout
- Visibility timeout menor que tempo de execução da Lambda

Solução:

- Ajustar visibility timeout
- Corrigir erro da Lambda
- Configurar DLQ

## Resposta comum em prova

- Logs: **CloudWatch Logs**
- Tracing: **X-Ray**
- Segredos: **Secrets Manager / Parameter Store**
- Retry/falhas: **DLQ**
- Acesso seguro a serviços AWS: **execution role**

---

# 3. API Gateway

## Sintoma

- API retorna 403
- API retorna 404
- API retorna 500
- CORS error no browser
- Lambda não é chamada
- Erro de autenticação

## Onde olhar

1. Método e path
2. Stage/deployment
3. Integração com Lambda
4. Permissão para API Gateway invocar Lambda
5. Authorizer
6. CORS
7. Logs do API Gateway e Lambda

## Causas comuns

### 403 Forbidden

Pode ser:

- IAM authorization habilitado
- Lambda authorizer/Cognito negando
- Resource policy bloqueando
- API key obrigatória e ausente

### 404 Not Found

Pode ser:

- Path errado
- Stage errado
- Método não configurado
- Deploy não realizado após alteração

### 500 Internal Server Error

Pode ser:

- Lambda explodiu
- Resposta da Lambda em formato inválido
- Erro na integração
- Permissão ausente para invocar Lambda

Para proxy integration, a Lambda geralmente precisa retornar:

```json
{
  "statusCode": 200,
  "headers": {
    "Content-Type": "application/json"
  },
  "body": "{\"message\":\"ok\"}"
}
```

### CORS

Sintoma típico: funciona no Postman, falha no browser.

Precisa responder headers como:

```http
Access-Control-Allow-Origin: *
Access-Control-Allow-Headers: Content-Type,Authorization
Access-Control-Allow-Methods: GET,POST,PUT,DELETE,OPTIONS
```

## Resposta comum em prova

- API para Lambda: **API Gateway + Lambda proxy integration**
- Auth de usuário final: **Cognito User Pools authorizer**
- CORS no browser: configurar CORS no API Gateway/resposta Lambda
- Logs: habilitar **CloudWatch Logs**

---

# 4. SQS

## Sintoma

- Mensagem processada várias vezes
- Mensagem some temporariamente e volta
- Consumidor processa duplicado
- Fila acumulando mensagens
- Lambda consome SQS mas falha

## Conceitos-chave

- SQS Standard: pelo menos uma entrega; pode duplicar; ordem não garantida
- SQS FIFO: ordem garantida e deduplicação
- Visibility timeout: tempo em que a mensagem fica invisível após ser recebida
- DLQ: fila para mensagens que falharam muitas vezes

## Causas comuns

### Mensagem sendo processada de novo

Provável:

- Consumidor falhou antes de deletar a mensagem
- Visibility timeout expirou
- Lambda deu erro

Solução:

- Aumentar visibility timeout
- Corrigir erro
- Usar DLQ
- Garantir processamento idempotente

### Precisa garantir ordem

Use **SQS FIFO**.

### Precisa evitar duplicação lógica

Use:

- FIFO com deduplication
- Idempotência no consumidor

## Resposta comum em prova

- Desacoplamento: **SQS**
- Falhas repetidas: **DLQ**
- Ordem exata: **SQS FIFO**
- Processamento duplicado: **idempotência**

---

# 5. SNS

## Sintoma / necessidade

- Um evento precisa notificar vários sistemas
- Fanout para múltiplas filas
- Enviar email/SMS/push

## Quando usar

Use SNS quando a mesma mensagem precisa ir para múltiplos assinantes.

Exemplo comum:

```text
SNS Topic
 ├── SQS Queue A
 ├── SQS Queue B
 └── Lambda
```

## Resposta comum em prova

- Pub/sub: **SNS**
- Fanout: **SNS + SQS**
- Vários consumidores independentes: cada consumidor com sua própria SQS

---

# 6. EventBridge

## Sintoma / necessidade

- Reagir a eventos de serviços AWS
- Agendar execução
- Integrar SaaS/event bus
- Roteamento baseado em padrão de evento

## Quando usar

Use EventBridge para arquitetura orientada a eventos.

Exemplos:

- Rodar Lambda todo dia às 8h
- Reagir a alteração em serviço AWS
- Roteamento de eventos por regra
- Integração com aplicações/SaaS

## Resposta comum em prova

- Schedule: **EventBridge Rule/Scheduler**
- Event bus: **EventBridge**
- Roteamento por padrão de evento: **EventBridge rules**

---

# 7. DynamoDB

## Sintoma

- Throttling
- Consulta lenta
- Scan caro
- Precisa consultar por outro campo
- Hot partition
- Condição de concorrência

## Onde olhar

1. Partition key
2. Sort key
3. GSI/LSI
4. RCU/WCU
5. Access pattern
6. Uso de Query vs Scan

## Causas comuns

### Está usando Scan

`Scan` lê a tabela inteira ou grande parte dela.

Melhor:

- Modelar a chave corretamente
- Usar `Query`
- Criar GSI para novo padrão de acesso

### Precisa buscar por campo que não é chave

Use **GSI**.

### Throttling

Possíveis soluções:

- On-demand capacity
- Aumentar provisioned capacity
- Melhorar distribuição da partition key
- Evitar hot partition

### Concorrência: evitar sobrescrever dado

Use conditional writes.

Exemplo conceitual:

```text
Atualize somente se version = X
```

### TTL

Para expirar itens automaticamente, use **DynamoDB TTL**.

## Resposta comum em prova

- Evitar Scan: use **Query**
- Novo access pattern: use **GSI**
- Baixa latência e escala: **DynamoDB**
- Expiração automática: **TTL**
- Concorrência: **conditional writes / optimistic locking**

---

# 8. S3

## Sintoma

- AccessDenied ao acessar objeto
- Site estático não abre
- Arquivo não atualiza no CloudFront
- Precisa criptografar objetos
- Precisa upload temporário seguro

## Onde olhar

1. Bucket policy
2. IAM policy
3. ACLs, se usadas
4. Block Public Access
5. Encryption settings
6. CloudFront cache
7. CORS

## Causas comuns

### AccessDenied

Pode ser:

- IAM não permite `s3:GetObject`
- Bucket policy bloqueia
- Block Public Access ativo
- Objeto criptografado com KMS e sem permissão no KMS

### Upload direto do browser/app

Use **pre-signed URL**.

### Site estático público

Precisa:

- Static website hosting habilitado
- Bucket policy permitindo leitura pública, se for público
- Block Public Access ajustado

### Objeto atualizado mas usuário vê versão antiga

Provável cache no CloudFront.

Solução:

- Invalidation
- Versionamento no nome do arquivo

## Resposta comum em prova

- Upload/download temporário: **pre-signed URL**
- Criptografia: **SSE-S3 ou SSE-KMS**
- Cache/CDN: **CloudFront**
- Arquivo privado via CDN: **CloudFront OAC/OAI**

---

# 9. CloudFront

## Sintoma

- Conteúdo antigo aparecendo
- Access denied no S3 origin
- Precisa reduzir latência global
- Precisa HTTPS/custom domain

## Causas comuns

### Conteúdo antigo

CloudFront cacheou.

Solução:

- Invalidation
- Alterar nome do arquivo com versão/hash
- Ajustar TTL

### S3 privado com CloudFront

Use CloudFront com acesso privado ao bucket:

- OAC/OAI
- Bucket policy permitindo acesso pelo CloudFront

## Resposta comum em prova

- Reduzir latência global: **CloudFront**
- Cache antigo: **Invalidation**
- S3 privado atrás de CDN: **CloudFront OAC/OAI**

---

# 10. CloudWatch

## Para que serve

- Logs
- Métricas
- Alarmes
- Dashboards
- Logs Insights

## Sintomas

- Precisa investigar erro da Lambda
- Precisa alarmar alta taxa de erro
- Precisa ver métricas de fila, API, Lambda etc.

## Resposta comum em prova

- Logs de Lambda: **CloudWatch Logs**
- Alarme por métrica: **CloudWatch Alarms**
- Consultar logs: **CloudWatch Logs Insights**
- Métricas customizadas: **CloudWatch custom metrics**

---

# 11. X-Ray

## Para que serve

Tracing distribuído.

Use quando precisar entender:

- Latência entre serviços
- Gargalo em chamada externa
- Caminho da requisição
- Erros em arquitetura distribuída

## Resposta comum em prova

- Logs: CloudWatch
- Métricas: CloudWatch
- Tracing: X-Ray

---

# 12. Secrets Manager vs Parameter Store

## Secrets Manager

Use para:

- Senhas
- Credenciais de banco
- API keys sensíveis
- Rotação automática de segredo

## SSM Parameter Store

Use para:

- Configuração da aplicação
- Parâmetros simples
- Valores não secretos
- Segredos simples com SecureString

## Resposta comum em prova

| Necessidade | Serviço |
|---|---|
| Segredo com rotação | Secrets Manager |
| Config simples | SSM Parameter Store |
| String segura mais simples/barata | SSM SecureString |
| Criptografia base | KMS |

---

# 13. KMS

## Para que serve

Gerenciar chaves de criptografia.

## Sintomas

- Não consegue ler objeto S3 criptografado
- Não consegue descriptografar segredo
- AccessDenied envolvendo `kms:Decrypt`

## Causa comum

Não basta permissão no S3/Secrets/etc. Também precisa permissão na chave KMS.

Exemplo de ação necessária:

```text
kms:Decrypt
```

## Resposta comum em prova

- Criptografia gerenciada: **KMS**
- AccessDenied em dado criptografado: checar permissões na **KMS key policy/IAM policy**

---

# 14. Cognito

## Quando usar

- Login de usuário final
- Registro de usuários
- Federação com Google/Facebook/SAML/OIDC
- JWT para API Gateway

## Componentes

| Componente | Uso |
|---|---|
| User Pool | Autenticação de usuários |
| Identity Pool | Credenciais AWS temporárias para usuários |

## Resposta comum em prova

- Login do usuário da aplicação: **Cognito User Pool**
- Dar acesso temporário a recursos AWS: **Cognito Identity Pool**
- Proteger API Gateway com usuário logado: **Cognito Authorizer**

---

# 15. CI/CD — CodePipeline, CodeBuild, CodeDeploy

## CodePipeline

Orquestra o pipeline.

Exemplo:

```text
Source -> Build -> Test -> Deploy
```

## CodeBuild

Executa build/testes/comandos.

Usa geralmente `buildspec.yml`.

## CodeDeploy

Gerencia deploy.

Suporta:

- In-place
- Blue/green
- Canary
- Linear

Para Lambda, é comum usar CodeDeploy para canary/linear deployment.

## Resposta comum em prova

| Necessidade | Serviço |
|---|---|
| Orquestrar pipeline | CodePipeline |
| Rodar build/testes | CodeBuild |
| Deploy controlado/canary/blue-green | CodeDeploy |
| Guardar artefato | S3 / CodeArtifact dependendo do caso |

---

# 16. Elastic Beanstalk

## Quando usar

Quando quer fazer deploy de app web sem gerenciar toda a infraestrutura manualmente.

Beanstalk pode provisionar:

- EC2
- Load Balancer
- Auto Scaling
- Health checks
- Deploy strategies

## Troubleshooting

Verifique:

- Eventos do Beanstalk
- Health status
- Logs da instância
- Security groups
- Variáveis de ambiente
- Plataforma correta

## Resposta comum em prova

- App web com menos overhead operacional: **Elastic Beanstalk**
- Precisa customizar infra profundamente: talvez ECS/EC2/CloudFormation, dependendo do cenário

---

# 17. ECS / Containers

## Sintoma

- Task não sobe
- Container reinicia
- Não consegue puxar imagem
- Serviço não recebe tráfego
- Task não acessa AWS services

## Onde olhar

1. Task definition
2. Container logs
3. IAM task role
4. Execution role
5. Security groups
6. Load balancer target group
7. ECR permissions

## Diferença importante

### Task execution role

Usada pelo ECS para:

- Puxar imagem do ECR
- Escrever logs no CloudWatch

### Task role

Usada pela aplicação dentro do container para:

- Acessar DynamoDB
- Acessar S3
- Acessar SQS
- etc.

## Resposta comum em prova

- Container precisa acessar AWS service: **task role**
- ECS precisa puxar imagem/logar: **task execution role**
- Menos gerenciamento de servidor: **Fargate**

---

# 18. VPC / Rede

## Sintoma

- Lambda/EC2/ECS não acessa internet
- Não consegue acessar RDS
- Timeout de conexão
- Serviço privado inacessível

## Onde olhar

1. Subnet pública ou privada
2. Route table
3. Internet Gateway
4. NAT Gateway
5. Security Groups
6. NACLs
7. VPC endpoints

## Regras rápidas

### Subnet pública

Tem rota para Internet Gateway:

```text
0.0.0.0/0 -> igw-xxxx
```

### Subnet privada com internet de saída

Tem rota para NAT Gateway:

```text
0.0.0.0/0 -> nat-xxxx
```

### Security Group

Stateful.

Se permite entrada, a resposta de saída é permitida automaticamente.

### NACL

Stateless.

Precisa liberar entrada e saída.

## Resposta comum em prova

- Recurso privado acessando internet: **NAT Gateway**
- Internet pública entrando: **Internet Gateway + subnet pública**
- Acesso privado a S3/DynamoDB sem internet: **VPC Endpoint**
- Controle de tráfego na instância/recurso: **Security Group**
- Controle no nível de subnet: **NACL**

---

# 19. RDS

## Sintoma

- App não conecta no banco
- Timeout
- Access denied
- Banco indisponível
- Precisa backup/restore

## Onde olhar

1. Security group do RDS
2. Subnet group
3. Credenciais
4. Endpoint/porta
5. Multi-AZ
6. Backups/snapshots

## Causas comuns

### Timeout

Provável rede/security group.

Verifique se o SG do RDS permite entrada a partir do SG da aplicação na porta do banco.

### Access denied

Provável usuário/senha/permissão no banco.

### Alta disponibilidade

Use Multi-AZ.

### Escala de leitura

Use Read Replicas.

## Resposta comum em prova

- Alta disponibilidade: **Multi-AZ**
- Escalar leitura: **Read Replica**
- Backup pontual: **automated backups / point-in-time recovery**
- Segredo de conexão: **Secrets Manager**

---

# 20. CloudFormation / IaC

## Sintoma

- Stack falhou
- Rollback
- Recurso não pode ser deletado
- Drift entre template e infra real

## Onde olhar

1. Events da stack
2. Logical resource que falhou
3. IAM permissions
4. Dependencies
5. Resource limits/names conflicts
6. Drift detection

## Resposta comum em prova

- Infra como código AWS nativo: **CloudFormation**
- Ver diferença entre template e real: **Drift detection**
- Evitar deletar recurso crítico: **DeletionPolicy: Retain**

---

# 21. Erros clássicos e resposta provável

## “Funciona no Postman, mas não no browser”

Pense em:

- CORS
- Origin
- Authorization headers
- Cookies/SameSite

Na prova, quase sempre é **CORS**.

---

## “Preciso reduzir operational overhead”

Prefira:

- Lambda
- DynamoDB
- API Gateway
- S3
- Managed services
- Serverless

Evite:

- EC2 manual
- Scripts manuais
- Servidor gerenciado por você

---

## “Preciso desacoplar sistemas”

Resposta provável:

- SQS
- SNS + SQS
- EventBridge

---

## “Preciso processar mensagens sem perder em falhas”

Resposta provável:

- SQS + DLQ
- Retry
- Idempotência

---

## “Preciso que vários serviços recebam o mesmo evento”

Resposta provável:

- SNS fanout
- EventBridge, se for event bus/routing/event pattern

---

## “Preciso guardar senha de banco”

Resposta provável:

- Secrets Manager

Se falar rotação automática, é quase certeza **Secrets Manager**.

---

## “Preciso guardar configuração da aplicação”

Resposta provável:

- SSM Parameter Store

---

## “Preciso investigar latência entre microserviços”

Resposta provável:

- X-Ray

---

## “Preciso de log da Lambda”

Resposta provável:

- CloudWatch Logs

---

## “Preciso alarmar quando erro aumentar”

Resposta provável:

- CloudWatch Alarm

---

## “Preciso deploy gradual de Lambda”

Resposta provável:

- CodeDeploy canary/linear

---

## “Preciso consultar DynamoDB por outro campo”

Resposta provável:

- GSI

---

## “DynamoDB está lento/caro porque varre tudo”

Resposta provável:

- Evitar Scan
- Usar Query
- Remodelar chave
- Criar GSI

---

## “Objeto S3 privado acessado por tempo limitado”

Resposta provável:

- Pre-signed URL

---

## “CloudFront entrega conteúdo antigo”

Resposta provável:

- Invalidation
- TTL
- Versionar nome dos arquivos

---

# 22. Checklist mental para qualquer questão

Pergunte:

1. É problema de permissão?
   - IAM role/policy/trust/resource policy

2. É problema de rede?
   - VPC, subnet, route table, SG, NACL, NAT, IGW

3. É problema de retry/falha assíncrona?
   - SQS, DLQ, visibility timeout, idempotência

4. É problema de observabilidade?
   - CloudWatch Logs/Metrics/Alarms, X-Ray

5. É problema de segredo/configuração?
   - Secrets Manager, Parameter Store, KMS

6. É problema de deploy?
   - CodePipeline, CodeBuild, CodeDeploy

7. É problema de escala/overhead?
   - Preferir serverless/managed services

---

# 23. Decisões rápidas

| Pergunta | Resposta provável |
|---|---|
| Precisa rodar código sob demanda | Lambda |
| Precisa expor endpoint HTTP | API Gateway |
| Precisa login de usuário | Cognito User Pool |
| Precisa credencial AWS temporária para usuário | Cognito Identity Pool |
| Precisa desacoplar produtor/consumidor | SQS |
| Precisa fanout | SNS |
| Precisa event bus/schedule | EventBridge |
| Precisa logs | CloudWatch Logs |
| Precisa métrica/alarme | CloudWatch Metrics/Alarms |
| Precisa tracing | X-Ray |
| Precisa segredo com rotação | Secrets Manager |
| Precisa config | SSM Parameter Store |
| Precisa criptografia/chave | KMS |
| Precisa NoSQL serverless | DynamoDB |
| Precisa consultar DynamoDB por novo campo | GSI |
| Precisa arquivo/objeto | S3 |
| Precisa CDN | CloudFront |
| Precisa upload temporário | S3 pre-signed URL |
| Precisa deploy canary Lambda | CodeDeploy |
| Precisa build | CodeBuild |
| Precisa pipeline | CodePipeline |
| Precisa app web gerenciado | Elastic Beanstalk |
| Precisa container sem gerenciar servidor | ECS Fargate |

---

# 24. Pegadinhas de prova

## Access keys hardcoded

Quase sempre errado.

Prefira IAM Role.

---

## EC2 manual quando existe managed service

Se a questão fala “least operational overhead”, EC2 manual geralmente está errado.

---

## Scan no DynamoDB

Se o volume é grande, Scan geralmente está errado.

Prefira Query/GSI.

---

## Lambda em VPC privada acessando internet

Precisa NAT Gateway.

---

## SQS Standard não garante ordem

Se precisa ordem, use FIFO.

---

## Mensagem duplicada

Mesmo com SQS, sua aplicação deve ser idempotente.

---

## CloudWatch vs X-Ray

- CloudWatch: logs/métricas/alarmes
- X-Ray: tracing/caminho/latência entre serviços

---

## Secrets Manager vs Parameter Store

- Secrets Manager: segredo sensível, rotação
- Parameter Store: configuração, parâmetro simples

---

# 25. Mini plano de revisão de véspera

## Prioridade 1

- IAM
- Lambda
- API Gateway
- DynamoDB
- SQS/SNS/EventBridge
- CloudWatch/X-Ray

## Prioridade 2

- S3/CloudFront
- Secrets Manager/Parameter Store/KMS
- CodePipeline/CodeBuild/CodeDeploy
- Cognito

## Prioridade 3

- ECS/Fargate
- Elastic Beanstalk
- RDS
- VPC básico
- CloudFormation

---

# 26. Última regra

Na dúvida, procure a alternativa que:

1. Usa serviço gerenciado
2. Reduz operação manual
3. Usa IAM Role em vez de credencial fixa
4. Desacopla componentes
5. Tem retry/DLQ quando é assíncrono
6. Usa CloudWatch/X-Ray para investigar
7. Usa KMS/Secrets Manager para segurança
8. Evita Scan e modela DynamoDB pelo padrão de acesso

Essa é a lógica que salva muita questão.

# DVA-C02 — 02 — Security + Deployment

> Objetivo: revisão rápida dos Domains 2 e 3 da AWS Certified Developer - Associate.

Fonte-base: AWS Exam Guide DVA-C02 — Domain 2: Security e Domain 3: Deployment.

---

## Peso na prova

- **Security: 26%**.
- **Deployment: 24%**.
- Juntos: **50%** do conteúdo pontuado.

Se você tem pouco tempo, esses dois domínios precisam de revisão forte.

---

# PARTE 1 — SECURITY

## Mental model da prova

A prova costuma perguntar:

- “Como a aplicação deve acessar outro serviço AWS com segurança?”
- “Onde guardar segredo/token/senha?”
- “Como criptografar dado em repouso/em trânsito?”
- “Qual policy/role permite essa chamada?”
- “Como fazer autenticação/autorização?”
- “Como aplicar menor privilégio?”

---

# 1. IAM básico para Developer

## Principal

Quem faz a ação:

- IAM user
- IAM role
- AWS service
- Federated identity
- Application

## Action

O que pode fazer:

- `s3:GetObject`
- `dynamodb:PutItem`
- `lambda:InvokeFunction`
- `kms:Decrypt`

## Resource

Onde a ação pode acontecer:

- Bucket específico
- Tabela específica
- Função Lambda específica
- Key KMS específica

## Effect

- `Allow`
- `Deny`

Deny explícito sempre vence allow.

---

# 2. Identity-based policy vs Resource-based policy

## Identity-based policy

- Anexada a usuário, grupo ou role.
- Diz o que essa identidade pode fazer.

Exemplo mental:

> “Essa Lambda role pode ler a tabela DynamoDB X.”

## Resource-based policy

- Anexada ao recurso.
- Diz quem pode acessar o recurso.

Exemplos:

- S3 bucket policy.
- Lambda resource policy.
- SQS queue policy.
- KMS key policy.

Exemplo mental:

> “Essa fila SQS aceita mensagens do SNS topic X.”

---

# 3. IAM Role

## O que é

- Identidade assumível temporariamente.
- Usa credenciais temporárias via STS.
- Melhor que credencial fixa.

## Casos comuns

- Lambda execution role.
- EC2 instance profile.
- ECS task role.
- Cross-account role.
- CI/CD role.

## Lambda execution role

Permissões que a função Lambda tem para acessar outros serviços.

Exemplo:

- Lambda precisa ler S3 → role precisa de `s3:GetObject`.
- Lambda precisa escrever DynamoDB → role precisa de `dynamodb:PutItem`.
- Lambda precisa logar → role precisa de permissões CloudWatch Logs.

---

# 4. AssumeRole e STS

## STS

- Security Token Service.
- Gera credenciais temporárias.

## AssumeRole

- Uma identidade assume uma role.
- Muito comum em cross-account.

## GetSessionToken (MFA)

- API do STS que retorna **credenciais temporárias** de um IAM user.
- Usada quando a chamada exige **MFA**.
- Diferente de AssumeRole: aqui você não troca de identidade, só obtém credenciais temporárias do próprio user (tipicamente para satisfazer MFA).

### Para funcionar

1. A identidade chamadora precisa permissão `sts:AssumeRole`.
2. A role de destino precisa confiar na identidade chamadora na trust policy.

Se faltar um dos dois, dá erro.

---

# 5. Autenticação vs Autorização

## Autenticação

“Quem é você?”

Exemplos:

- Cognito User Pools.
- OIDC/SAML identity provider.
- JWT/bearer token.

## Autorização

“O que você pode fazer?”

Exemplos:

- IAM policy.
- Cognito groups/claims.
- Lambda authorizer.
- App-level RBAC/ABAC.

---

# 6. Cognito

## User Pool

- Diretório de usuários.
- Login, cadastro, tokens JWT.
- Autenticação de usuários finais.

## Identity Pool

- Troca identidade federada por credenciais AWS temporárias.
- Permite acessar serviços AWS diretamente com IAM roles.

### Na prova

- Login de usuário/app → User Pool.
- App precisa credenciais AWS temporárias para acessar S3 etc. → Identity Pool.

---

# 7. Bearer tokens / JWT

## Bearer token

- Quem possui o token pode usá-lo.
- Deve trafegar por HTTPS.
- Não logar tokens.
- Validar assinatura, expiração e claims.

## API Gateway Authorizers

- Cognito authorizer.
- Lambda authorizer.
- JWT authorizer em HTTP APIs.

---

# 8. Criptografia

## Em trânsito

- TLS/HTTPS.
- Protege dados durante comunicação.

## Em repouso

- Dados armazenados criptografados.
- Exemplos:
  - S3 SSE-S3/SSE-KMS.
  - DynamoDB encryption at rest.
  - RDS encryption.
  - EBS encryption.

---

## Server-side encryption vs Client-side encryption

### Server-side encryption

- AWS criptografa ao armazenar.
- Aplicação envia dado em texto claro por TLS; AWS criptografa no serviço.
- Mais simples.

Tipos comuns em S3:

- SSE-S3: chave gerenciada pelo S3.
- SSE-KMS: chave no AWS KMS.
- SSE-C: cliente fornece chave.

### Client-side encryption

- Aplicação criptografa antes de enviar para AWS.
- AWS armazena dado já criptografado.
- Mais controle, mais responsabilidade.

---

# 9. KMS

## Conceitos

- Serviço de gerenciamento de chaves.
- Customer managed key.
- AWS managed key.
- Key policy.
- Grants.
- Encrypt/decrypt.
- Envelope encryption.
- Key rotation.

## Envelope encryption

- KMS protege uma data key.
- A data key criptografa os dados.
- Mais eficiente para dados grandes.

## Key policy

- Controla quem pode usar/administar a key.
- Para cross-account, key policy precisa permitir conta/role externa.

## Rotação

- AWS managed keys têm rotação automática gerenciada.
- Customer managed symmetric keys podem ter rotação automática habilitada.

---

# 10. Secrets e dados sensíveis

## Nunca fazer

- Hardcodar segredo no código.
- Commitar `.env` com credenciais.
- Logar token/senha/PII.
- Colocar segredo em texto claro em environment variable sem controle.

## AWS Secrets Manager

- Guardar senhas, tokens, credenciais.
- Suporta rotação automática para alguns serviços.
- Bom para secrets com ciclo de rotação.

## SSM Parameter Store

- Guardar configuração e parâmetros.
- SecureString usa KMS.
- Bom para configs e secrets mais simples.

## Environment variables em Lambda

- Podem ser criptografadas.
- Ainda assim, para segredo sensível, prefira Secrets Manager/SSM.

---

# 11. Data masking e sanitization

## Data masking

- Esconder parte do dado.
- Exemplo: CPF `***.***.***-12`, cartão `**** **** **** 1234`.

## Sanitization

- Remover/limpar dado sensível de logs, payloads e respostas.

## Multi-tenant

- Garantir isolamento por tenant.
- Pode envolver:
  - partition key com tenant.
  - claims no token.
  - validação no app.
  - IAM conditions.
  - ABAC.

---

# Checklist Security

- [ ] IAM role vs user.
- [ ] Identity policy vs resource policy.
- [ ] Trust policy + `sts:AssumeRole`.
- [ ] Lambda execution role.
- [ ] Cognito User Pool vs Identity Pool.
- [ ] Bearer token/JWT e HTTPS.
- [ ] KMS key policy, encrypt/decrypt, rotation.
- [ ] Encryption at rest vs in transit.
- [ ] SSE-S3 vs SSE-KMS vs client-side encryption.
- [ ] Secrets Manager vs SSM Parameter Store.
- [ ] Não logar segredo/PII.
- [ ] Menor privilégio.

---

# PARTE 2 — DEPLOYMENT

## Mental model da prova

A prova pergunta:

- “Como empacotar e publicar aplicação?”
- “Como testar em ambiente dev/stage/prod?”
- “Como automatizar deploy?”
- “Como fazer rollback?”
- “Qual estratégia reduz risco?”
- “Como versionar Lambda/API?”

---

# 12. Artefatos de aplicação

## O que pode ser artefato

- Zip de Lambda.
- Container image.
- Template SAM/CloudFormation.
- Build output.
- Arquivos estáticos no S3.
- Configurações por ambiente.

## Dependências

- Dev dependencies não devem ir para produção quando desnecessário.
- Reduzir package size ajuda cold start.
- Layers podem compartilhar libs entre Lambdas.

---

# 13. Configuração por ambiente

## Exemplos

- dev
- test
- staging
- prod

## Formas comuns

- Environment variables.
- SSM Parameter Store.
- Secrets Manager.
- AWS AppConfig.
- Stage variables no API Gateway.
- Lambda aliases.

---

# 14. AWS SAM

## O que é

- Serverless Application Model.
- Extensão do CloudFormation para serverless.
- Facilita definir Lambda, API Gateway, DynamoDB etc.

## `Transform` no template

- O parâmetro `Transform: AWS::Serverless-2016-10-09` no template CloudFormation declara que é um template **SAM** (especifica a versão da macro SAM).
- O CloudFormation expande a sintaxe SAM para os recursos reais.

## Comandos úteis (CLI)

- `sam build` — compila/empacota dependências.
- `sam local invoke` / `sam local start-api` — testa Lambda/API localmente.
- `sam package` — **só empacota** e faz upload do artefato pro S3.
- `sam deploy` — empacota **e** faz deploy (upload no S3 + cria/atualiza a stack).
- `sam publish` — publica no **AWS Serverless Application Repository**.

## Na prova

- Testar Lambda localmente.
- Criar eventos JSON de teste.
- Deploy de stack serverless.
- Usar templates para múltiplos ambientes.

---

# 15. CloudFormation / IaC

## Conceito

- Infraestrutura como código.
- Stack representa conjunto de recursos.
- Change sets mostram alterações antes de aplicar.

## Importante

- Templates versionáveis.
- Rollback em falha.
- Parâmetros por ambiente.
- Outputs/export para integração.

## Cross-stack reference (Export / ImportValue)

- Uma stack expõe um valor com `Outputs` + `Export: { Name: ... }`.
- Outra stack consome com `Fn::ImportValue`.
- Use quando um recurso criado numa stack (ex.: ARN, VPC id) precisa ser referenciado em outra.

## Gerar valores únicos (ex.: license keys)

- Recurso `AWS::Secrets​Manager::Secret` com `GenerateSecretString`, ou um **custom resource** (Lambda) para gerar/registrar chaves no deploy.

---

# 16. Lambda deployment packaging

## Zip package

- Código + dependências empacotados em zip.
- Pode usar layers.
- Comum para funções menores.
- Em CloudFormation (`AWS::Lambda::Function`):
  - `Code.ZipFile`: forma mais simples de deployar — código **inline** no template (só runtimes interpretados, ex.: Python/Node).
  - `Code.S3Bucket`/`S3Key`: aponta para o zip já no S3 (funções maiores/com dependências).

## Container image

- Lambda pode executar imagem de container.
- Útil para dependências grandes/custom runtime.
- Imagem armazenada no ECR.

## Layers

- Compartilham dependências/código comum.
- Podem reduzir duplicação.
- Cuidado com versionamento.

---

# 17. Lambda versions e aliases

## Version

- Snapshot imutável de uma função.
- Depois de publicada, não muda.

## Alias

- Ponteiro para uma version.
- Pode apontar para uma ou mais versões com pesos.
- Útil para canary/gradual rollout.

Exemplo mental:

- alias `prod` aponta 90% para v1 e 10% para v2.

---

# 18. API Gateway stages

## Stages

- Representam ambientes/versionamentos de uma API.
- Exemplo: `/dev`, `/test`, `/prod`.

## Stage variables

- Variáveis por stage.
- Podem apontar para diferentes aliases Lambda/configs.

## Custom domain

- Domínio próprio para API.
- Pode mapear base paths para stages/APIs.

---

# 19. CI/CD na AWS

## CodeCommit

- Repositório Git gerenciado pela AWS.

## CodeBuild

- Build/test em ambiente gerenciado.
- Usa `buildspec.yml`.
- Pode gerar artefatos.

## CodeDeploy

- Faz deploy para Lambda, ECS, EC2/on-prem.
- Estratégias: canary, linear, all-at-once, blue/green dependendo do alvo.

## CodePipeline

- Orquestra source → build → test → deploy.
- Integra com CodeCommit/GitHub/S3/CodeBuild/CodeDeploy/CloudFormation.

## CodeArtifact

- Repositório gerenciado de **pacotes/dependências** (npm, pip, Maven, NuGet etc.).
- Substitui hospedar seu próprio repositório de pacotes.
- Emite eventos para **EventBridge** quando uma versão é publicada → pode disparar pipeline (ex.: rebuild ao atualizar lib).

---

# 20. Deployment strategies

## All-at-once

- Tudo de uma vez.
- Mais rápido.
- Mais arriscado.

## Rolling

- Atualiza em lotes.
- Menos risco que all-at-once.

## Blue/green

- Dois ambientes: blue atual, green novo.
- Tráfego muda para green.
- Facilita rollback.

## Canary

- Pequena porcentagem recebe nova versão primeiro.
- Se saudável, aumenta tráfego.
- Muito comum em Lambda/API.

## Linear

- Aumenta tráfego em incrementos fixos.

### Na prova

- “Minimizar impacto” → canary/blue-green.
- “Rollback rápido” → blue-green/alias rollback.
- “Validar nova versão com poucos usuários” → canary.

---

# 21. Rollback

## Formas comuns

- CodeDeploy rollback automático por CloudWatch alarm.
- Lambda alias volta para versão anterior.
- CloudFormation rollback de stack.
- Blue/green volta tráfego para blue.

---

# 22. Testes

## Unit tests

- Testam código isolado.
- Não dependem de AWS real.

## Integration tests

- Testam integração com serviços reais ou mocks.
- Úteis para API Gateway, Lambda, DynamoDB, SQS etc.

## Test events

- Payloads JSON para Lambda.
- Eventos de API Gateway, S3, SQS, EventBridge.

## Event-driven tests

- Validar payload, schema, retries, DLQ, idempotência.

---

# 23. AppConfig

## O que é

- Gerencia configuração de aplicação.
- Permite deploy gradual de configuração.
- Pode validar config antes de aplicar.
- Útil para feature flags e configs dinâmicas.

---

# Checklist Deployment

- [ ] Artefatos: zip, image, template, static assets.
- [ ] Lambda package: zip vs container image vs layer.
- [ ] SAM build/local/deploy conceitualmente.
- [ ] CloudFormation stack/change set/rollback/parameters.
- [ ] Lambda version vs alias.
- [ ] API Gateway stage/stage variable/custom domain.
- [ ] CodeBuild/buildspec/artifacts.
- [ ] CodeDeploy strategies e rollback.
- [ ] CodePipeline orquestra workflow.
- [ ] Canary vs blue-green vs rolling vs all-at-once.
- [ ] Test events para Lambda/API/SQS/EventBridge.
- [ ] Config por ambiente com env vars/SSM/Secrets/AppConfig.

---

# Red flags de prova

- “Não hardcodar segredo” → Secrets Manager/SSM + IAM role.
- “Acessar AWS programaticamente de Lambda” → execution role, não access key.
- “Cross-account falhando” → falta `sts:AssumeRole` ou trust policy.
- “Usuário final login” → Cognito User Pool.
- “Usuário/app precisa credenciais AWS temporárias” → Cognito Identity Pool.
- “Criptografia com controle de chave/auditoria” → SSE-KMS/KMS.
- “Deploy gradual de Lambda” → versions + aliases + CodeDeploy.
- “Rollback automático” → CodeDeploy + CloudWatch alarms.
- “Ambientes dev/prod para API” → API Gateway stages.
- “Testar Lambda local/serverless” → SAM.


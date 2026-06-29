### EC2

  -> Detach data (non-root) volume: unmount first, pode destacar com a instância RODANDO
  -> Detach ROOT volume: precisa PARAR (stop) a instância antes

### AWS SAM

-> "Transform" section specifies the version of the AWS SAM to use, in your CloudFormation Template
-> AWS SAM uses cloudformation under the hood ( Important to know )
-> "sam deploy" package publishes to s3 and deploy
-> "sam build": resolve dependencies from the functions in the SAM Template
-> "sam package": SÓ faz upload do artefato pro S3 (não deploya)
-> "sam local invoke" / "sam local start-api": testa Lambda/API localmente antes do deploy

### Lambda

-> InvalidParameterValueException: Returned if the package and the IAM role is unable to assume. 
-> Create Lambda: Needs a package and a execution role to be created
-> ZipFile property on CF can contain the execution code of your lambda. 

Layers
  -> Pull in additional code and content
  -> Can add libraries without needing to include in the final deployment package (that has a limit in size for direct uploads)
  -> Keep package small
  -> Máx 5 layers por função
  -> Limites: 50 MB zipped (upload direto) / 250 MB unzipped (código + layers). Maior que isso = container image (até 10 GB) ou via S3

### CloudFormation
  -> Start services directly from the template code can be used with "cfn-init"
  -> cfn-signal + CreationPolicy: instância sinaliza "pronta"; stack só avança após sucesso (evita CREATE_COMPLETE antes da app subir)
  -> DeletionPolicy: Retain / Snapshot pra preservar dados quando o recurso/stack é deletado

Stack Sets
  -> Deploya stacks CF em múltiplas CONTAS **e** REGIÕES de uma vez

### Dynamo DB 

-> RCU: 1 RCU = 1 leitura strongly-consistent/s para item até 4 KB (eventually-consistent = 2 leituras por RCU)
   Fórmula: ceil(itemSize / 4KB) x leituras/s   (divide por 2 se eventually-consistent)
-> WCU: 1 WCU = 1 escrita/s para item até 1 KB
   Fórmula: ceil(itemSize / 1KB) x escritas/s

### Elastic Beanstalk

Blue Green Deployment
  -> When updating to a new web server/application-server etc... use the "Blue Green Deployment" for major updates (ex: Java 7 to Java 8)
  -> Also the Blue Green deployment can be use to send users to diferent environments and redirect traffic.
  -> Deploy to a separate environment
  -> Least impact on availability


All at once deployment
  -> view changes quickly
  -> Fast deploy
  -> Deploy all instances simultaneously

Immutable
  -> Deploy the new version to a fresh group of instances

Rolling
  -> Deployn in Batches ( Each batch is taken out during deployment )

Rolling with additional batches
  -> Deploy in Batches witha first launch of batches to avoid downtimes and ensure full capacity

Traffic Splitting
  -> Canary do Beanstalk: novas instâncias recebem uma % do tráfego real pra validar antes do shift total

Quick-pick de prova:
  -> Capacidade total durante deploy: Rolling w/ additional batches OU Immutable
  -> Mais seguro + rollback rápido: Immutable (nova ASG, termina tudo se falhar)
  -> Zero downtime + mudança grande/de plataforma (ex: nova versão de SO): Blue/Green (troca o CNAME)
  -> Mais barato/rápido mas com downtime e tudo afetado se falhar: All at once



### CodePipeine & CodeDeploy & CodeCommit (CI/CD)
  -> Can deploy to EC2 instances and OnPremises servers
  -> Linear deploy configuration slowly shift the traffic to new versiosn 

Types of deployments
  -> InPlace deployments
  -> Blue Green deployment

Restrictions 
  -> Lambda & ECS: SÓ blue/green (traffic shifting: AllAtOnce / Canary / Linear)
  -> EC2 and onpremises (Hybrid): ambos Blue/Green e InPlace
  -> appspec.yml define o deploy + os hooks; EC2/on-prem precisam do CodeDeploy agent instalado

Lifecycle events (hooks no appspec.yml)
  -> BeforeAllowTraffic: roda tarefas antes de redirecionar o tráfego pra nova versão
  -> AfterAllowTraffic: roda tarefas depois que todo o tráfego foi deslocado

Canary Deploy
  -> Shift the traffic in two increments, can use percentange to define the increments

Linear deploy
  -> Shift deploy in equal increments, can define the number of interval between each increment


### ECS

Tasks placement strategies

  -> Binpack: empacota tasks pra deixar a MENOR sobra de CPU/memória -> menos instâncias -> menor custo
  -> Spread: Place tasks evenly based on key-pair-values. host, or instanceId
  -> random: Place tasks random





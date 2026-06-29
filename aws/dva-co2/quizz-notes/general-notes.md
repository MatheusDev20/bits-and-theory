## Concepts


### Lambda 
Easiste Way to Deploy an Lambda
    - ZipFile paramter in the AWS::Lambda::Function CloudFormation Template
    - Code paramter can be used to python and javascript inline code in Cloudformation

Dead Letter Queue
  -> Configure an DLQ: Parameter DeadLetterConfig: with an SQS ARN

Best Practices
  – Separate the Lambda handler (entry point) from your core logic.
  – Take advantage of Execution Context reuse to improve the performance of your function
  – Use AWS Lambda Environment Variables to pass operational parameters to your function.
  – Control the dependencies in your function’s deployment package.
  – Minimize your deployment package size to its runtime necessities.
  – Reduce the time it takes Lambda to unpack deployment packages
  – Minimize the complexity of your dependencies
  – Avoid using recursive code

Memory and CPU
  -> Increase the memory also increase the CPU, so for CPU Heavy tasks increase the memory. 

### Dynamo DB

Scalabilty
  -> Serverless DB that can start small and scale to millions
  -> Storage can scale to terabytes 

Dynamo DB Acelerator ( DAX ) 
  -> In memory Caching layer in front of the Dynamo DB table to accelerate requests.
  -> Less development overhead and cost eficiently

Global Secondary Index (GSI)
  -> Index with an partition key and a sort key ( Alternative to partition key PK )
  -> Used to create different access patterns.
  -> Can be different from the base table 
  -> To avoid throttling must increase the read and write capacity with the table

Local Secondary Index (LSI)
  -> Alternative sort key for a given PK
  -> Same PK as the base table but diferent SK
  -> Used to have greater query or scan flexibility 
  -> 5 LSI per table
  -> Cannot add to a table, create during table creation


TTL (Time to live)
  -> Define items that expire and are automatically deleted.
  -> No extra cost
  -> Used to reduce cost of storage

Dynamo DB Streams
  -> Information about changed items in a table
  -> 24 hour lifetime
  -> Stream Record Contains information about the single item in the DynamoDB
  -> Can configure "Before" and "After" images of the modified items with the "NEW_AND_OLD_IMAGES" value to the Parameter StreamViewType
  -> Can get just the "Before" with the parameter StreamViewType="OLD_IMAGE"
  -> Can interact with SNS and lambda to build reactive systems that react to table changes events ( SNS Notification lambda execution code )

Projection Expressions
  -> Returns only specific attributes from operations like GetItem Scan or Query (Kinda like a custom select not a select *)

Filter Expressions
  -> Determines what items to be return, not the attributes ( The Where clause )

### AWS CloudFormation
  What is
    -> Template to create resources in AWS
    -> Can reference newly created resources with "Export" keyword and use them in other templates with "Fn::ImportValue"


### AWS SAM
  -> Supported by AWS Cloudformation to provide serverless applications (Dynamo, API GW, Lambdas) 
  -> SAM Syntax is converted in AWS Cloudofmraton syntax to create the actual resources.
  -> AWS Cloudformation can be used, but for serverless applications SAM is recommended. 

Commands ( CLI )
  -> sam deploy: package and deploy application (uploads to S3 AND deploy)
  -> sam package: Just package (upload to s3 )
  -> sam:publish: just publish to the AWS serverless application repository 


### EC2
  Return the instance metadata -> http://{Ip}/latest/meta-data/
    

### S3 
    <MaxAgeSeconds>3600</MaxAgeSeconds> -> CORS config that make Options preflight for 3600s (1h)

Event Notification
    -> Can respond to diferent events on the bucket like ObjectCreated:PUT to trigger 
        – Amazon SQS queue
        – AWS Lambda function
        – Amazon SNS topic
        – Amazon EventBridge


S3 Transfer Acceleration
  -> Transfer files over long distances

Encryption
  -> Use the header x-amz-server-side-encryption to encrypt with S3 Encryption keys SSE-S3 AES-256

### AWS-X-RAY
  -> Request Tracing of services in AWS 
  -> SubSegments Application view of the downstream service logs

### AWS CodeArtifact

  -> Related to store and managing npm packages or others
  -> Can respond to events, live event bridge to trigger pipelines to update versions of the packages


### API Gateway 

Cache
  -> Invalidate the cache is just use the Cache-Control: max-age=0 header in the requests. 


### Security

MFA temporary credentials
  -> GetSessionToken API to return temporary credentials of an IAM user

### SNS
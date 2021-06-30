# pwa-cloudfront
Angular PWA Application Deployed to S3 and CloudFront.
Pre requisite Steps:
pre-step1-s3repo -> terraform apply -var-file="dev.tfvars"
1) Create s3 bucket
2) Create ECR repository

3) Copy repository endpoint
Deploy Quote Lambda backend service
pre-step2-apibackend -> terraform apply -var-file="dev.tfvars"
4) Copy the api endpoint and build PWA
ng new ngdemo
-- Adding PWA support
ng add @angular/pwa
ng build
5) Upload files to s3 
aws s3 sync ./dist/ngdemo s3://cp-bucket-20210630
6)
Create & update AWS Certificate ARN , Specify bucket name variable
Validate certificate


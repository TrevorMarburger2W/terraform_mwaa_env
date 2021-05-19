# MWAA Terraform
<p style="color: gray;">Everything you need to bootstrap an AWS MWAA Environment with Terraform.</p>
<br>
<br>

## About AWS MWAA
<hr>

Apache Airflow has been used for years to orchestrate workflows and data pipelines.  In late 2020, Amazon Web Services realeased [Managed Workflows for Apache Airflow](https://docs.aws.amazon.com/mwaa/latest/userguide/what-is-mwaa.html) (MWAA) to provide a serverless, managed method to quickly spin up an Airflow environment.

<br>

## About This Repo
<hr>

The MWAA service requires additional AWS resources for its launch and operation. In the Console, an environment can be quickly created, and these services are provisioned in the process.  This process becomes somewhat convoluted with AWS-supplied CloudFormation templates & even moreso undocumented in Terraform.

This repository provides Terraform modules to launch all necessary AWS resources to get an MWAA environment up and running, which include:

1. A [custom VPC](modules/vpc) with:
    - An associated Internet Gateway
    - Two public subnets
    - Two private subnets
    - Two private subnets
    - Two NAT Gateways w/Elastic IPs for each public subnet
    - An associated route table w/routes for public & private subnets
    - A Security group

2. An [S3 Storage Bucket](modules/s3) with:
    - A Folder for DAGs
    - Bucket rules to restrict access

3. An [MWAA Environment](modules/mwaa)

<br>
<br>

## Running the Terraform Modules
<hr>

To get started, clone this repository on the machine that will be running Terraform & run  `$ terraform init` to initialize the project.

Next, set the following three environment variables:

<pre>
export TF_VAR_mwaa_aws_access_key="{YOUR_AWS_ACCESS_KEY}"
export TF_VAR_mwaa_aws_secret_key="{YOUR_AWS_SECRET_KEY}"
export TF_VAR_mwaa_exec_role="{IAM_ROLE_TO_EXECUTE_AIRFLOW}"
</pre>

Inspect the custom variable values in top-level TF [file](main.tf), changing as needed to accomodate VPC and subnet CIDR ranges, AWS Region, S3 bucket name, etc.

Finally, run `$ terraform apply` to create the MWAA environment.  If there are any misconfigurations, AWS provide a very useful tool to check for proper MWAA environment configurations [here](https://github.com/awslabs/aws-support-tools/tree/master/MWAA).
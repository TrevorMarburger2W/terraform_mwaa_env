module "network" {
    source              = "./modules/vpc"

    mwaa_aws_access_key = "${var.mwaa_aws_access_key}" # TF_VAR_mwaa_aws_access_key
    mwaa_aws_secret_key = "${var.mwaa_aws_secret_key}" # TF_VAR_mwaa_aws_secret_key
    vpc_env_name        = "mwaa-default"
    aws_region          = "us-east-1"
    vpc_cidr_block      = "10.192.0.0/16"
    pub_subnet_1_cidr   = "10.192.10.0/24"
    pub_subnet_2_cidr   = "10.192.11.0/24"
    priv_subnet_1_cidr  = "10.192.20.0/24"
    priv_subnet_2_cidr  = "10.192.21.0/24"
}

module "storage" {
    source              = "./modules/s3"

    aws_region          = "us-east-1"
    mwaa_aws_access_key = "${var.mwaa_aws_access_key}" # TF_VAR_mwaa_aws_access_key
    mwaa_aws_secret_key = "${var.mwaa_aws_secret_key}" # TF_VAR_mwaa_aws_secret_key
    
    bucket_name         = "airflow-test-bucket-001"
    dag_path            = "dags/"
}

module "airflow" {
    source                     = "./modules/mwaa"

    mwaa_aws_access_key        = "${var.mwaa_aws_access_key}" # TF_VAR_mwaa_aws_access_key
    mwaa_aws_secret_key        = "${var.mwaa_aws_secret_key}" # TF_VAR_mwaa_aws_secret_key

    mwaa_webserver_access_mode = "PUBLIC_ONLY"
    env_name                   = "mwaa_env_1"
    aws_region                 = "us-east-1"
    bucket_arn                 = module.storage.s3_arn
    dag_path                   = module.storage.bucket_dag_key
    execution_role             = "${var.mwaa_exec_role}" # TF_VAR_mwaa_exec_role
    sec_group_id               = module.network.sec_group
    subnet_ids                 = [
        module.network.priv_subnet_1,
        module.network.priv_subnet_2
    ]
}

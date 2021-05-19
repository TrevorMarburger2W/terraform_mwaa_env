resource "aws_mwaa_environment" "mwaa_env_1" {
  name               = "${var.env_name}"
  source_bucket_arn  = "${var.bucket_arn}"
  dag_s3_path        = "${var.dag_path}"
  execution_role_arn = "${var.execution_role}"

  airflow_configuration_options = {
    "core.store_dag_code" = false
  }

  # PUBLIC OR PRIVATE UI ACCESS
  webserver_access_mode = "${var.mwaa_webserver_access_mode}"

  logging_configuration {
    dag_processing_logs {
      enabled   = true
      log_level = "DEBUG"
    }

    scheduler_logs {
      enabled   = true
      log_level = "INFO"
    }

    task_logs {
      enabled   = true
      log_level = "INFO"
    }

    webserver_logs {
      enabled   = true
      log_level = "WARNING"
    }

    worker_logs {
      enabled   = true
      log_level = "CRITICAL"
    }
  }

  network_configuration {
    security_group_ids = [
      "${var.sec_group_id}"
    ]
    subnet_ids = var.subnet_ids[*]
  }

  tags = {
    Group = "mwaa_env"
  }

}
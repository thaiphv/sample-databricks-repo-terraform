terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.3.0"
    }
  }

  required_version = "~> 0.13.5"
}

provider "databricks" {
  profile = terraform.workspace
}

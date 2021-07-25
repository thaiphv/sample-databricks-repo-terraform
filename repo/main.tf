terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.3.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.1.0"
    }
  }
}

locals {
  language_by_extensions = {
    "py"    = "PYTHON"
    "r"     = "R"
    "sc"    = "SCALA"
    "scala" = "SCALA"
    "sql"   = "SQL"
  }
}

data "external" "git_repo" {
  program = [
    "${path.module}/git_checkout.sh"
  ]

  query = {
    "git_repo_name" = var.git_repo_name
    "git_repo_url"  = var.git_repo_url
  }
}

resource "databricks_notebook" "repo" {
  for_each = fileset(data.external.git_repo.result.git_repo_dir, "**/*.{py,r,sc,scala,sql}")

  source   = "${data.external.git_repo.result.git_repo_dir}/${each.value}"
  path     = "/Repos/deploy/promoted/${var.git_repo_name}/${replace(each.value, "/\\.(py|r|sc|scala|sql)/", "")}"
  language = local.language_by_extensions[split(".", each.value)[length(split(".", each.value)) - 1]]
}

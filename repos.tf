module "repo" {
  for_each = {
    // "repo-1" = "git@github.com:thaiphv/repo-1.git",
    // "repo-2" = "git@github.com:thaiphv/repo-2.git",
  }

  source = "./repo"

  git_repo_name = each.key
  git_repo_url  = each.value
}

variable "github_api_key" {}
terraform {
    backend "s3" {
        bucket = "partinfra-tfsync"
        key    = "github/terraform.tfstate"
        region = "us-east-1"
    }
}


provider "github" {
    token        = "${var.github_api_key}"
    organization = "mozilla-parsys"
}

resource "github_repository" "meta" {
    name        = "meta"
    description = "Configures this org"
    has_issues  = "true"
}

# Admins
resource "github_membership" "admin_nemo" {
  username = "johngian"
  role     = "admin"
}

resource "github_membership" "admin_tasos" {
  username = "akatsoulas"
  role     = "admin"
}

# Bitergia team
resource "github_team" "bitergia" {
    name        = "bitergia"
    privacy     = "closed"
}

resource "github_team_membership" "bitergia_dicortazar" {
  team_id  = "${github_team.bitergia.id}"
  username = "dicortazar"
  role     = "member"
}

resource "github_team_membership" "bitergia_flamingspaz" {
  team_id  = "${github_team.bitergia.id}"
  username = "flamingspaz"
  role     = "maintainer"
}

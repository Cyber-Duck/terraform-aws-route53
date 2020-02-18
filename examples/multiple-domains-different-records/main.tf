# ---------------------------------------------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ---------------------------------------------------------------------------------------------------------------------

provider "aws" {
  region = var.aws_region
}

module "zones" {
  source = "../.."

  name = ["mineiros.io", "mineiros.com"]
}

module "mineiros-io" {
  source = "../.."

  zone_id = module.zones.zone["mineiros.io"].zone_id

  records = [
    {
      type = "A"
      ttl  = 300
      records = [
        "10.0.0.1",
        "10.0.0.2",
      ]
    },
    {
      type = "TXT"
      ttl  = 300
      records = [
        "txt1",
        "txt2"
      ]
    },
  ]
}

module "mineiros-com" {
  source = "../.."

  zone_id = module.zones.zone["mineiros.com"].zone_id

  records = [
    {
      type = "A"
      ttl  = 300
      records = [
        "10.0.0.3",
        "10.0.0.4",
      ]
    },
  ]
}

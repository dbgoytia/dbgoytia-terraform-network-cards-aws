terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      region = "us-east-1"
    }
  }
  backend "s3" {
    bucket = "b2fa3adb-18c6-3df8-dabd-f099a6fd8dad-backend"
    key    = "terraform.tfstate"
    region = "us-east-1"
 }
}

provider "aws" {
  region = "us-east-1"
}

provider "template" {
}

resource "random_uuid" "randomid" {}


resource "aws_iam_user" "circleci" {
  name = "circleci-user"
  path = "/system/"
}

resource "aws_iam_access_key" "circleci" {
  user = aws_iam_user.circleci.name
}

resource "local_file" "circle_credentials" {
  filename = "tmp/circleci_credentials"
  content  = "${aws_iam_access_key.circleci.id}\n${aws_iam_access_key.circleci.secret}"
}


module "network" {
  source            = "git@github.com:dbgoytia/networks-tf.git"
  vpc_cidr_block    = "10.0.0.0/16"
  cidr_block_subnet = "10.0.1.0/24"
}
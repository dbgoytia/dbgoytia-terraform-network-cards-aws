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

module "instances" {
  source        = "git@github.com:dbgoytia/instances-tf.git"
  instance-type = "t2.micro"
  ssh-key-arn = "arn:aws:secretsmanager:us-east-1:779136181681:secret:dgoytia-ssh-key-2-6JJZH2"
  key_pair_name = "dgoytia"
  servers-count = 2
  vpc_id        = module.network.VPC_ID
  subnet_id     = module.network.SUBNET_ID
}
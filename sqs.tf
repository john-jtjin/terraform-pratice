module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "3.3.0"

  name                      = "104-sqs"
  receive_wait_time_seconds = 20
}
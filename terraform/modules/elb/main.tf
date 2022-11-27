module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "4.0.0"

  name = var.elb_name

  subnets         = var.public_subnets
  security_groups = [aws_security_group.elb_sg.id]
  internal        = false

  listener = [
    {
      instance_port     = 8080
      instance_protocol = "http"  
      lb_port           = 80
      lb_protocol       = "http"
    }
    # {
    #   instance_port     = 8080
    #   instance_protocol = "http"
    #   lb_port           = 443
    #   lb_protocol       = "http"
    #   ssl_certificate_id = ""
    # },
  ]

  health_check = {
    target              = "HTTP:8080/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
  
  access_logs = {
    bucket = aws_s3_bucket.elb_logs.id
  }
  // ELB attachments
  number_of_instances = length(var.ec2_instance_ids)
  instances           = var.ec2_instance_ids
  tags = {
    Name = var.elb_name
    terraform = "true"
    env = var.env
    costcenter = var.costcenter
  }
}


#######################
## S3 Bucket For ELB Logs
#######################

data "aws_elb_service_account" "this" {}

resource "aws_s3_bucket" "elb_logs" {
  bucket        = "${var.elb_name}-access-log-bucket"
  force_destroy = true

  tags = {
    Name = "${var.elb_name}-access-log-bucket"
    terraform = "true"
    env = var.env
    costcenter = var.costcenter
  }
}
data "aws_iam_policy_document" "elb_logs" {
  statement {
    actions = [
      "s3:PutObject",
    ]
    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.this.arn]
    }
    resources = [
      "arn:aws:s3:::${var.elb_name}-access-log-bucket/*",
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "elb_logs" {
    bucket = aws_s3_bucket.elb_logs.id
    rule {
      object_ownership = "BucketOwnerEnforced"
    }
}
resource "aws_s3_bucket_public_access_block" "elb_logs" {
    bucket = aws_s3_bucket.elb_logs.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "elb_logs" {
    bucket = aws_s3_bucket.elb_logs.bucket
    rule {
        id = "expire_rule"
        expiration {
            days = 90
        }
        filter {}
        status = "Enabled"
    }
}

resource "aws_s3_bucket_policy" "elb_logs" {
    bucket = aws_s3_bucket.elb_logs.id
    policy = data.aws_iam_policy_document.elb_logs.json
}
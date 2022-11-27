module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.2.1"
  count = var.ec2_instance_count

  name = "${var.ec2_instance_name}-${count.index}"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  user_data = file(var.user_data_file_path)
  user_data_replace_on_change = true
  ami                    = var.ami_id
  instance_type          = var.instance_type
#   key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = var.private_subnets[count.index % length(var.private_subnets)]

  

  tags = {
    terraform   = "true"
    env = var.env
    costcenter = var.costcenter

  }
}

data "aws_iam_policy_document" "ec2_assume_role_policy" {
    statement {
      actions = ["sts:AssumeRole"]
      effect  = "Allow"
      principals {
        type        = "Service"
        identifiers = ["ec2.amazonaws.com"]
      }
    }
}

resource "aws_iam_role" "ec2_role" {
    name               = "${var.ec2_instance_name}-role"
    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
}
data "aws_iam_policy" "policy_for_ssm" {
    arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "policy_for_cloudwatchagent" {
    arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
resource "aws_iam_role_policy_attachment" "ec2_ssm_role_attach" {
    role       = aws_iam_role.ec2_role.name
    policy_arn = data.aws_iam_policy.policy_for_ssm.arn
}

resource "aws_iam_role_policy_attachment" "ec2_cloudwatchagent_role_attach" {
    role       = aws_iam_role.ec2_role.name
    policy_arn = data.aws_iam_policy.policy_for_cloudwatchagent.arn
}
resource "aws_iam_instance_profile" "ec2_instance_profile" {
    name = "${var.ec2_instance_name}-profile"
    role = aws_iam_role.ec2_role.name
}
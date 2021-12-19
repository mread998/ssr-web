resource "aws_iam_role" "ssm-enabled" {
    assume_role_policy    = jsonencode(
        {
            Statement = [
                {
                    Action    = "sts:AssumeRole"
                    Effect    = "Allow"
                    Principal = {
                        Service = "ec2.amazonaws.com"
                    }
                },
            ]
            Version   = "2012-10-17"
        }
    )
    description           = "Allows EC2 instances to call AWS services on your behalf."
    force_detach_policies = false
    max_session_duration  = 3600
    name                  = "ssm-enabled-role"
    path                  = "/"
      tags = merge(
        var.shared-tags,
        {
        Name = "ssm-enabled"
        },
  )
}

resource "aws_iam_role_policy_attachment" "ssm-enabled-instance" {
  role       = aws_iam_role.ssm-enabled.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm-enabled-cloudwatch" {
  role       = aws_iam_role.ssm-enabled.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "ssm-enabled-ec2-ro" {
  role       = aws_iam_role.ssm-enabled.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ssm-enabled" {
  name = "ssm-enabled-role"
  role = aws_iam_role.ssm-enabled.name
}
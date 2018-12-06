resource "aws_iam_role" "ecs-jenkins-role" {
  name = "${var.env}-${var.identifier}-jenkins-ecs-jenkins-role"
  assume_role_policy = "${data.aws_iam_policy_document.ecs-task-role-assume.json}"
}

resource "aws_iam_role_policy_attachment" "ecs-jenkins" {
  role = "${aws_iam_role.ecs-jenkins-role.name}"
  policy_arn = "${aws_iam_policy.ecs-jenkins-role-policy.arn}"
}

resource "aws_iam_policy" "ecs-jenkins-role-policy" {
  name = "${var.env}-${var.identifier}-jenkins-agent-ecs-iam-role-policy"
  policy = "${data.aws_iam_policy_document.ecs-jenkins-role.json}"
}

data "aws_iam_policy_document" "ecs-jenkins-role" {

  # https://wiki.jenkins.io/display/JENKINS/Amazon+EC2+Plugin

  statement {
    sid = "AllowInstanceOperations"
    effect = "Allow"
    actions = [
      "ec2:ModifyInstanceAttribute",
      "ec2:RunInstances",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:RebootInstances",
      "ec2:TerminateInstances",
      "ec2:DescribeInstances",
      "ec2:CreateTags",
      "ec2:ResetInstanceAttribute"
    ]
    resources = [ "*" ]
  }

}

data "aws_iam_policy_document" "ecs-task-role-assume" {
  statement {
    effect = "Allow"
    actions = [ "sts:AssumeRole" ]
    principals {
      type = "Service"
      identifiers = [ "ecs-tasks.amazonaws.com" ]
    }
  }
}


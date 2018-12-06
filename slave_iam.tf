resource "aws_iam_instance_profile" "jenkins-slave" {
  name = "${var.env}-${var.identifier}-jenkins-slave-instance-profile"
  role = "${aws_iam_role.jenkins-slave-instance-role.name}"
}

resource "aws_iam_role" "jenkins-slave-instance-role" {
  name = "${var.env}-${var.identifier}-iam-jenkins-slave-service-role"
  assume_role_policy = "${data.aws_iam_policy_document.jenkins-slave-assume-role.json}"
}

data "aws_iam_policy_document" "jenkins-slave-assume-role" {
  statement {
    sid = "AssumeEc2Role"
    actions = [ "sts:AssumeRole" ]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

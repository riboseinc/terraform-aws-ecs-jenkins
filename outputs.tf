output "ecs-task-definition-arn" {
  value = "${aws_ecs_task_definition.jenkins.arn}"
}

output "ecs-task-definition-family" {
  value = "${aws_ecs_task_definition.jenkins.family}"
}

output "slave-sg-name" {
  value = "${aws_security_group.ec2-slave.name}"
}

output "slave-iam-instance-profile-name" {
  value = "${aws_iam_instance_profile.jenkins-slave.name}"
}

output "slave-iam-instance-profile-arn" {
  value = "${aws_iam_instance_profile.jenkins-slave.arn}"
}

output "slave-iam-instance-profile-role-id" {
  value = "${aws_iam_role.jenkins-slave-instance-role.id}"
}

output "ecs-iam-instance-profile-role-id" {
  value = "${aws_iam_role.ecs-jenkins-role.id}"
}

output "elb-int-name" {
  value = "${aws_elb.int.name}"
}
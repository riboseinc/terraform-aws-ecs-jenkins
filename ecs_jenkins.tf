resource "aws_ecs_task_definition" "jenkins" {
  family = "${var.env}-${var.identifier}-jenkins-task"

  task_role_arn = "${aws_iam_role.ecs-jenkins-role.arn}"
  # TODO: Network mode awsvpc can only be used with alb/nlbs, we need
  # to use the new lb.tf.TODO file to replace elb.tf before we can enable
  # this
  #network_mode = "awsvpc"
  network_mode = "bridge"

  volume {
    name = "${var.mount_point}"
    host_path = "/mnt/${var.mount_point}"
  }

  container_definitions = <<EOF
[
  {
    "name": "${var.env}-${var.identifier}-ecs-task",
    "image": "${var.container_image}",
    "privileged": true,
    "readonlyRootFilesystem": false,
    "cpu": 1,
    "memory": 5120,
    "essential": true,
    "environment": [
      {
        "name": "JAVA_OPTS",
        "value": "${var.jenkins-java-opts}"
      }
    ],
    "mountPoints": [
      {
        "sourceVolume": "${var.mount_point}",
        "containerPath": "/var/${var.mount_point}"
      }
    ],
    "portMappings": [
      {
        "containerPort": ${var.ports["jenkins_backup_scp"]},
        "hostPort": ${var.ports["jenkins_backup_scp"]}
      },
      {
        "containerPort": ${var.ports["jenkins_http"]},
        "hostPort": ${var.ports["jenkins_http"]}
      },
      {
        "containerPort": ${var.ports["jnlp"]},
        "hostPort": ${var.ports["jnlp"]}
      }
    ]
  }
]
EOF

}

resource "aws_ecs_service" "jenkins" {
  name = "${var.env}-${var.identifier}-jenkins-ecs-service"
  cluster = "${var.ecs-cluster-id}"
  task_definition = "${aws_ecs_task_definition.jenkins.arn}"
  desired_count = "${var.enable-service == "true" ? 1 : 0}"
  iam_role = "${var.ecs-scheduler-role-arn}"

  load_balancer {
    elb_name = "${aws_elb.int.id}"
    container_name = "${var.env}-${var.identifier}-ecs-task"
    container_port = "${var.ports["jenkins_http"]}"
  }
}

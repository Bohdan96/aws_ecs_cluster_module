output "cluster_name" {
  description = "The name of the ECS cluster."
  value       = var.cluster_name
}

output "task_execution_role_arn" {
  description = "ECS tasks execution role arn."
  value       = aws_iam_role.ecsTaskExecutionRole.arn
}

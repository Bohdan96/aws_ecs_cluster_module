output "cluster_name" {
  description = "The name of the ECS cluster."
  value       = module.ecs_cluster_complete.cluster_name
}

output "task_execution_role_arn" {
  description = "ECS tasks execution role arn."
  value       = module.ecs_cluster_complete.task_execution_role_arn
}


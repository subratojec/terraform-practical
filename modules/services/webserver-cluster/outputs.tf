output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "The Domain name of the Load Balancer."
}

output "launch_template_id" {
  value = aws_launch_template.example.id
}

output "target_group_arn" {
  value = aws_lb_target_group.asg.arn
}

output "aws_asg_name" {
  value = aws_autoscaling_group.example.name
  description = "The name of the Auto Scaling Group"
}
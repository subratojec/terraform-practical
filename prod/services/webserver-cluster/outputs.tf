output "alb_dns_name" {
  value = module.webserver-cluster.alb_dns_name
  description = "The Domain name of the Load Balancer."
}
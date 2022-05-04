output "ALB_ARN" {
  value = aws_lb.alb.arn
}

output "LISTENER_ARN" {
  value = var.INTERNAL ? null : aws_lb_listener.private.*.arn[0]
}

variable "lb_cookie_stickiness_policies" {
  description = <<EOT
Map of lb_cookie_stickiness_policies, attributes below
Required:
    - lb_port
    - load_balancer
    - name
Optional:
    - cookie_expiration_period
    - region
EOT

  type = map(object({
    lb_port                  = number
    load_balancer            = string
    name                     = string
    cookie_expiration_period = optional(number)
    region                   = optional(string)
  }))
  validation {
    condition = alltrue([
      for k, v in var.lb_cookie_stickiness_policies : (
        v.cookie_expiration_period == null || (v.cookie_expiration_period >= 0)
      )
    ])
    error_message = "must be at least 0"
  }
}


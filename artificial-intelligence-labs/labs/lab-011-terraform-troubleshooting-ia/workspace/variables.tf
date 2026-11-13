variable "backend_host" {
  type    = string
  default = "backend"
}

variable "backend_port" {
  type    = number
  default = 8000
  validation {
    condition     = var.backend_port > 0 && var.backend_port < 65536
    error_message = "backend_port precisa estar entre 1 e 65535."
  }
}

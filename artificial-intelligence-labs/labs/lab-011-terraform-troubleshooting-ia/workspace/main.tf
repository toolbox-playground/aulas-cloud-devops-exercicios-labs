terraform {
  required_version = ">= 1.6"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
}

# Configuração do proxy gerada a partir de um template
resource "local_file" "nginx_conf" {
  filename = "${path.module}/saida/nginx.conf"
  content = templatefile("${path.module}/templates/nginx.conf.tftpl", {
    backend_host = var.backend_host
    backend_port = var.backend_port
  })
}

# Variáveis de ambiente da aplicação
resource "local_file" "app_env" {
  filename = "${path.module}/saida/app.env"
  content  = "SERVICE=pedidos-api\nPORT=${var.backend_port}\n"
}

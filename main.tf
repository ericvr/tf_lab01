terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}

variable "reponame" {}
variable "container_port" {}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "${var.reponame}"   // Cambiarla dinámicamente por la Variable env.DOCKER_REPO que está en el Jenkins
  ports {
    internal = 80
    external = ${var.container_port}  // Cambiarla dinámicamente por la variable CONTAINER_PORT que está en el Jenkins.
  }
}

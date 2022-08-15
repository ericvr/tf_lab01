terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "gonzafirma"   // Cambiarla dinámicamente por la Variable env.DOCKER_REPO que está en el Jenkins
  ports {
    internal = 80
    external = 80  // Cambiarla dinámicamente por la variable CONTAINER_PORT que está en el Jenkins.
  }
}


terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_network" "app_network" {
  name = "local-devops-network"
}

resource "docker_image" "app_image" {
  name = "local-devops-app:1.0"

  build {
    context = "../app"
  }
}

resource "docker_container" "app_container" {
  name  = "local-devops-app"
  image = docker_image.app_image.image_id

  ports {
    internal = 5000
    external = 5000
  }

  networks_advanced {
    name = docker_network.app_network.name
  }

  restart = "unless-stopped"
}

# Configure the Docker provider
provider "docker" {
  host = "tcp://127.0.0.1:2375"
}

# Create a container
resource "docker_container" "python" {
  image = "${docker_image.python.name}"
  count = 3
  name  = "docker_target_${count.index}"
  command = ["sleep", "1000000000000"]
  ports {
    internal = 880 + count.index
    external = 880 + count.index
  }
}

resource "docker_image" "python" {
  name = "python:2.7"
}


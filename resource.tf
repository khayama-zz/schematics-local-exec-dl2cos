resource "null_resource" "env" {
  provisioner "local-exec" {
    command = "env"
  }
}

resource "null_resource" "ping" {
  provisioner "local-exec" {
    command = "ping -c 4 10.0.80.11"
  }
}

resource "null_resource" "ping1" {
  provisioner "local-exec" {
    command = "ping -c 4 10.192.27.26"
  }
}

resource "null_resource" "ping2" {
  provisioner "local-exec" {
    command = "ping -c 4 10.192.27.49"
  }
}

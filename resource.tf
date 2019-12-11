resource "null_resource" "env" {
  provisioner "local-exec" {
    command = "env"
  }
}

resource "null_resource" "ping" {
  provisioner "local-exec" {
    command = "ping -c 4 10.0.80.11"
  }
  depends_on = [null_resource.env]
}

resource "null_resource" "whoami" {
  provisioner "local-exec" {
    command = "whoami"
    }
  depends_on = [null_resource.ping]
}

resource "null_resource" "uname" {
  provisioner "local-exec" {
    command = "uname -a"
  }
  depends_on = [null_resource.whoami]
}

resource "null_resource" "ibmcloud" {
  provisioner "local-exec" {
    command = "ibmcloud --version"
  }
  depends_on = [null_resource.uname]
}

resource "null_resource" "oc" {
  provisioner "local-exec" {
    command = "oc version"
  }
  depends_on = [null_resource.ibmcloud]
}

resource "null_resource" "terraform" {
  provisioner "local-exec" {
    command = "terraform --version"
  }
  depends_on = [null_resource.oc]
}

resource "null_resource" "python2" {
  provisioner "local-exec" {
    command = "python2 --version"
  }
  depends_on = [null_resource.terraform]
}

resource "null_resource" "python3" {
  provisioner "local-exec" {
    command = "python3 --version"
  }
  depends_on = [null_resource.python2]
}

resource "null_resource" "command" {
  provisioner "local-exec" {
    command = "echo $PATH | sed -e \"s/:/ /g\" | xargs ls -1 | sort -u"
  }
  depends_on = [null_resource.python3]
}

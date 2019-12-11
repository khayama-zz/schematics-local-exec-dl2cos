resource "null_resource" "env" {
  provisioner "local-exec" {
    command = "env"
  }
}

resource "null_resource" "ping" {
  depends_on = [null_resource.env]
  provisioner "local-exec" {
    command = "ping -c 4 10.0.80.11"
  }
}

resource "null_resource" "whoami" {
  depends_on = [null_resource.ping]
  provisioner "local-exec" {
    command = "whoami"
    }
}

resource "null_resource" "uname" {
  depends_on = [null_resource.whoami]
  provisioner "local-exec" {
    command = "uname -a"
  }
}

resource "null_resource" "ibmcloud" {
  depends_on = [null_resource.uname]
  provisioner "local-exec" {
    command = "ibmcloud --version"
  }
}

resource "null_resource" "oc" {
  depends_on = [null_resource.ibmcloud]
  provisioner "local-exec" {
    command = "oc version"
  }
}

resource "null_resource" "terraform" {
  depends_on = [null_resource.oc]
  provisioner "local-exec" {
    command = "terraform --version"
  }
}

resource "null_resource" "python2" {
  depends_on = [null_resource.terraform]
  provisioner "local-exec" {
    command = "python2 --version"
  }
}

resource "null_resource" "python3" {
  depends_on = [null_resource.python2]
  provisioner "local-exec" {
    command = "python3 --version"
  }
}

resource "null_resource" "command" {
  depends_on = [null_resource.python3]
  provisioner "local-exec" {
    command = "echo $PATH | sed -e \"s/:/ /g\" | xargs ls -1 | sort -u"
  }
}

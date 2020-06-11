variable "endpoint" {
  type        = "string"
  description = "https://control.cloud-object-storage.cloud.ibm.com/v2/endpoints"
  default = "s3.jp-tok.cloud-object-storage.appdomain.cloud"
}

resource "null_resource" "tfvars" {
  provisioner "local-exec" {
    command = "cat schematics.tfvars"
  }
}

resource "null_resource" "secretenv" {
  provisioner "local-exec" {
    command = "cat terraform-secret-env"
  }
}

resource "null_resource" "tfstate" {
  provisioner "local-exec" {
    command = "cat terraform.tfstate"
  }
}

resource "null_resource" "env" {
  provisioner "local-exec" {
    command = "env"
  }
}

resource "null_resource" "pwd" {
  provisioner "local-exec" {
    command = "pwd"
  }
}

resource "null_resource" "ls" {
  provisioner "local-exec" {
    command = "ls -l"
  }
}

resource "null_resource" "ip" {
  provisioner "local-exec" {
    command = "ip route && ip addr"
  }
}

resource "null_resource" "ping" {
  provisioner "local-exec" {
    command = "ping ${var.endpoint} -c 4"
  }
}

resource "null_resource" "dns" {
  provisioner "local-exec" {
    command = "cat /etc/resolv.conf"
  }
}
resource "null_resource" "whoami" {
  provisioner "local-exec" {
    command = "whoami"
    }
}

resource "null_resource" "uname" {
  provisioner "local-exec" {
    command = "uname -a"
  }
}

resource "null_resource" "ibmcloud" {
  provisioner "local-exec" {
    command = "ibmcloud --version"
  }
}

resource "null_resource" "oc" {
  provisioner "local-exec" {
    command = "oc version"
  }
}

resource "null_resource" "terraform" {
  provisioner "local-exec" {
    command = "terraform --version"
  }
}

resource "null_resource" "python2" {
  provisioner "local-exec" {
    command = "python2 --version"
  }
}

resource "null_resource" "python3" {
  provisioner "local-exec" {
    command = "python3 --version"
  }
}

resource "null_resource" "command" {
  provisioner "local-exec" {
    command = "echo $PATH | sed -e \"s/:/ /g\" | xargs ls -1 | sort -u"
  }
}

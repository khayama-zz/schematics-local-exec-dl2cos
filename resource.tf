variable "bucket_name" {
  type        = string
  description = "enter your IBM Cloud Object Storage bucket name"
  default = "khayama-icos"
}

variable "endpoint" {
  type        = string
  description = "https://control.cloud-object-storage.cloud.ibm.com/v2/endpoints"
  default = "s3.jp-tok.cloud-object-storage.appdomain.cloud"
}

variable "url" {
  type        = string
  description = "enter file download url"
  default = "http://ipv4.download.thinkbroadband.com/5MB.zip"
}

resource "null_resource" "curl" {

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command =<<EOT
      curl --version
      object_name=$(basename ${var.url})
      echo "basename is $object_name"
      content_type=$(curl -I ${var.url} | grep "Content-Type" | awk '{printf $2}')
      echo "content-type is $content_type"
      #filename=$(curl -I ${var.url} | grep "Content-Disposition" | cut -d \" -f 2)
      #echo "filename is $filename"
      #if [ -n "$filename" ]; then
      #  object_name="$filename"
      #fi
      wget -O $object_name -nv --no-check-certificate ${var.url} -P $PWD
      if [ $? -ne 0 ]; then
        echo "[ERROR] 正常にダウンロードできませんでした"
        exit 1
      fi
      ls -l
      curl -v -X PUT https://${var.bucket_name}.${var.endpoint}/$object_name -H "Authorization: Bearer $IC_IAM_TOKEN" -H "Content-Type: $content_type" -T $object_name
    EOT
  }
}

#resource "null_resource" "tfvars" {
#  provisioner "local-exec" {
#    command = "cat schematics.tfvars"
#  }
#}

#resource "null_resource" "secretenv" {
#  provisioner "local-exec" {
#    command = "cat terraform-secret-env"
#  }
#}

#resource "null_resource" "tfstate" {
#  provisioner "local-exec" {
#    command = "cat terraform.tfstate"
#  }
#}

#resource "null_resource" "env" {
#  provisioner "local-exec" {
#    command = "env"
#  }
#}

#resource "null_resource" "pwd" {
#  provisioner "local-exec" {
#    command = "pwd"
#  }
#}

#resource "null_resource" "ls" {
#  provisioner "local-exec" {
#    command = "ls -l"
#  }
#}

#resource "null_resource" "ip" {
#  provisioner "local-exec" {
#    command = "ip route && ip addr"
#  }
#}

#resource "null_resource" "dns" {
#  provisioner "local-exec" {
#    command = "cat /etc/resolv.conf"
#  }
#}

#resource "null_resource" "whoami" {
#  provisioner "local-exec" {
#    command = "whoami"
#    }
#}

#resource "null_resource" "uname" {
#  provisioner "local-exec" {
#    command = "uname -a"
#  }
#}

#resource "null_resource" "ibmcloud" {
#  provisioner "local-exec" {
#    command = "ibmcloud --version"
#  }
#}

#resource "null_resource" "oc" {
#  provisioner "local-exec" {
#    command = "oc version"
#  }
#}

#resource "null_resource" "terraform" {
#  provisioner "local-exec" {
#    command = "terraform --version"
#  }
#}

#resource "null_resource" "token" {
#  provisioner "local-exec" {
#    command = "echo $IC_IAM_TOKEN"
#  }
#}

#resource "null_resource" "python3" {
#  provisioner "local-exec" {
#    command = "python3 --version"
#  }
#}

#resource "null_resource" "command" {
#  provisioner "local-exec" {
#    command = "echo $PATH | sed -e \"s/:/ /g\" | xargs ls -1 | sort -u"
#  }
#}

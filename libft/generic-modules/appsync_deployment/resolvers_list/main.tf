# prepare list of filenames

resource "null_resource" "resolvers_list" {
  triggers = {
    always_run = "${timestamp()}"
  }

  # See autodeployment.sh for more details
  provisioner "local-exec" {
    command = "${path.module}/bin/autodeployment.sh ${var.resolvers_dir}"
  }
}

data "local_file" "resolvers_list" {
  depends_on = [
    null_resource.resolvers_list
  ]

  filename = "${path.module}/bin/resolvers.list"
}

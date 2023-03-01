# Checks if build folder has changed
data "external" "build_context" {
  program = ["${path.module}/bin/folder_contents.sh", "${var.build_context}"]
}

# Builds and pushes it into aws_ecr_repository
resource "null_resource" "build_and_push" {
  triggers = {
    build_folder_content_md5 = data.external.build_context.result.md5
  }

  # See build.sh for more details
  provisioner "local-exec" {
    command = "${path.module}/bin/build.sh -f ${var.build_context}/${var.dockerfile_name} -t ${var.ecr_repository_url}:${var.docker_image_tag} -c ${var.build_context}/"
  }
}

output "resolvers_list" {
  value = jsondecode(data.local_file.resolvers_list.content)
}

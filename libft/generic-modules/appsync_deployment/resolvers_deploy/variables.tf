variable "api_id" {
  type        = string
  description = "Id of the AppSync API"
}
variable "field" {
  type        = string
  description = "AppSync field"
}
variable "type" {
  type        = string
  description = "AppSync type"
}
variable "data_source" {
  type        = string
  description = "AppSync data source"
}
variable "kind" {
  type        = string
  description = "AppSync kind"
}
variable "request_template" {
  type        = string
  description = "AppSync request template"
}
variable "response_template" {
  type        = string
  description = "AppSync response template"
}

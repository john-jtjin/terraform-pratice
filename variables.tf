## common

variable "access_key" {
  description = "AWS access key"
  type        = string
  nullable    = false
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
  nullable    = false
}

variable "email" {
  description = "email"
  type        = string
  nullable    = false
}

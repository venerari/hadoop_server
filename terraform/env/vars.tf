variable "location" {
  type    = string
  default = "canadacentral"
}

variable "rg" {
  type    = string
  default = "hadoopcluster"
}

variable "ssh-source-address" {
  type    = string
  default = "*" # all access
  #default = "9xx.xx.xx.xx/32" #only my home access
}

variable "subscription_id" { default = "a78e87ab-f8bc-448a-9118-883078064d69" }
variable "tenant_id" { default = "78448480-3203-4553-bdb0-bf1dad1a07cd" }
variable "client_id" { default = "08009a36-bf30-4f05-9399-be3db446dc6a" }
variable "client_secret" { default = "k5zD8jK8rRpqTvPPsw0_98vs-OvzNz~i1E" }

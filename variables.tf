variable "environment" {
  description = "Environnement dev ou prod"
  type        = string
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment doit valoir dev ou prod."
  }
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  description = "Subnets publics des deux zones"
  type        = list(string)
}

variable "alb_security_group_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "instance_profile_name" {
  description = "Profil IAM autorisant la lecture du secret"
  type        = string
}

variable "user_data" {
  description = "Script de demarrage sans valeur secrete"
  type        = string
}

variable "min_size" {
  type    = number
  default = 2
  validation {
    condition     = var.min_size >= 2 && floor(var.min_size) == var.min_size
    error_message = "Le socle impose au moins deux instances."
  }
}

variable "max_size" {
  type    = number
  default = 4
}

variable "desired_capacity" {
  type    = number
  default = 2
}

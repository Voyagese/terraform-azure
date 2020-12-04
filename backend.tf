# terraform {
#   backend "azurerm" {
#     resource_group_name  = "storage_account_og"
#     storage_account_name = "dev1olga"
#     container_name       = "tfstate"
#     key                  = "prod.terraform.tfstate"
#     access_key           = "7szfGxbS7Txjjrsidj1A7WIgVZu3nXuGINkyZwEOrIKKRF/8cGcK5ykHFi4m1m8g++OeKhPHAkMnf4dvpuYLlA=="
#   }
# }



terraform {
    backend "s3"{
        bucket = "terraform18"
        key = "path/to/my/azure"
        region = "us-east-1"
    }
}
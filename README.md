![standard-readme compliant](https://img.shields.io/badge/Terraform-6B42BC?style=for-the-badge&logo=terraform&logoColor=white) ![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)

# Terraform Automation

Automation of Kubernetes infrastructure.

## Table of Contents
- [Goals](#Goals)
- [Install](#Install)
- [Usage](#Usage)
- [Maintainers](#Maintainers)

## Goals
The goals for this repository are:

1. Use Terraform to fully automate the creation of all Kubernetes Infrastructure.
2. Produce the code in such a way that's usable, readable and maintainable by third parties.
3. Ensure the code is able to be built upon and expanded to add additional infrastructure and features.
4. Keep in-line with IAC methodologies.

## Install
This project uses [Terraform](https://www.terraform.io/). You'll need to install Terraform along with [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/quickstart.html) to run this code. Once these are installed:
- Clone the repo:
```sh
$ git clone https://github.com/tekore/Aws
```

- Initialise Terraform
```sh
$ terraform init
```

## Usage
Update the config with the relevant variables needed for your infrastructure

Once this is done, run:
```sh
$ terraform plan 
$ terraform apply
```

## Maintainers
[@Tekore](https://github.com/tekore)

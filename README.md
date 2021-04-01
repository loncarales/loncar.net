# Loncar.net Blog

Tools I’ve used for this blog:

* [Hugo](https://gohugo.io/)
* [Packer](https://www.packer.io/)
* [Terraform](https://www.terraform.io/)
* [Ansible](https://docs.ansible.com/)

## Configuration files

Currently, all sensitive information, such as API tokens, API access keys, passwords, server IP addresses, … are stored in `-dist` files and are not containing the actual values. For all scripts to working correctly, we need first to copy the `-dist` files to right config files and add the exact parameters

```bash
$ cd iac
$ cp .envrc-dist .envrc
```

## Installing

### Build Debian Base image

```bash
$ cd iac
$ ./build.sh
```

### Deploy infrastructure with Terraform

```bash
$ cd iac
$ terraform init
$ terraform plan -out plan.out
$ terraform apply plan.out
```

### Provision software and configuration with Ansible

```bash
$ cd iac/ansible
$ # Let's use ping module to check if our machine is up and running
$ ansible hugo -i hosts.ini -u deploy --private-key ../pki/id_rsa_deploy -m ping
$ # install requirements
$ ansible-galaxy install -r requirements.yml
$ # provision machine
$ ansible-playbook -u deploy -i hosts.ini -l hugo --private-key ../pki/id_rsa_deploy -e cf_email=youremail.com -e cf_key=sdfsdfsdfljlbjkljlkjsdfoiwje provision-hugo.yml
```

## Generate static content and deploy it to the web server

```bash
$ cd iac/ansible
$ ansible-playbook -u deploy -i hosts.ini -l localhost,hugo --private-key ../pki/id_rsa_deploy -e content_user=$USER deploy-content.yml
```

## Testing with Vagrant

```bash
$ vagrant up
# Only loncar_net host should be listed
$ ansible-playbook -i hosts.ini -l loncar_net --list-hosts provision-hugo.yml
# Install all requirements to run hugo generated static pages
$ ansible-playbook -i hosts.ini -l loncar_net -e remote_user_name=vagrant -e cf_email=youremail.com -e cf_key=sdfsdfsdfljlbjkljlkjsdfoiwje provision-hugo.yml
# Generate static content and deploy it to the web server
$ ansible-playbook -i hosts.ini -l localhost,loncar_net -e remote_user_name=vagrant -e content_user=$USER deploy-content.yml
```

## Contributing

TBA

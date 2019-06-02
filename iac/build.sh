#!/usr/bin/env bash

echo "Creating private public SSH key pair for user deploy"
rm -f ./pki/id_rsa_deploy* || true
ssh-keygen -t rsa -b 4096 -N "" -C "deploy" -f ./pki/id_rsa_deploy

echo "Setting Environment Variables"
source .envrc

echo "Building Debian Base"
packer build debian-base.json

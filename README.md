# cbc install loader

This repo is a public entrypoint for startign the installation. Access to this repo does not grant access to any data or code.

## Instructions

To complete this installation, you will need access to the private cbcmortgage repo. To begin, you will need Ubuntu 24.04. As root run the following scripts:

- Install Git and run the loader:

``` sh
apt update && apt install -y git && git clone https://github.com/cbcmortgage/cbcinstall.git && bash cbcinstall/start.sh
```

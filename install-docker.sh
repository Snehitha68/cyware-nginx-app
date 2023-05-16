#!/bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo usermod -aG docker $USER 


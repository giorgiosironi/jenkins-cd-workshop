#!/bin/bash
set -e

sudo rm -rf jenkins_home/*
sudo git clean -fdX jenkins_home/

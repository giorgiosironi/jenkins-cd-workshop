#!/bin/bash
set -e

rm -rf jenkins_home/*
git clean -fdX jenkins_home/

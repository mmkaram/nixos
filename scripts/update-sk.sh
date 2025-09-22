#!/usr/bin/env bash

cd $USER/.ssh
ssh-keygen -K
ls -alh | grep sk


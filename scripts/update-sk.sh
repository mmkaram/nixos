#!/usr/bin/env bash

cd /home/$USER/.ssh
ssh-keygen -K
ls -alh | grep sk || true


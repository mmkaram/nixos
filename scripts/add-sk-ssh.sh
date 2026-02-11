#!/usr/bin/env bash

cd /home/$USER/.ssh
ssh-keygen -K
# TODO: Rename keys to id_ed25519_sk instead of id_ed25519_sk_rk_github-mmkaram
ls -alh | grep sk || true


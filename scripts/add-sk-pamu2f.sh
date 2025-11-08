#!/usr/bin/env bash

mkdir -p /home/$USER/.config/Yubico
touch /home/$USER/.config/Yubico/u2f_keys
pamu2fcfg > /home/$USER/.config/Yubico/u2f_keys
ls -alh /home/$USER/.config/Yubico/ | grep sk || true


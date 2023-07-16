#!/bin/bash

# Send email via Logwatch with detailed logs
sudo logwatch --detail high --mailto itsomniac@gmail.com --range All --service vsftpd --service sshd --format html --output mail

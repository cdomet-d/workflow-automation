#!/bin/bash

echo "Launching virtual machine..."
vboxmanage startvm "inception"
echo "Running command:"
echo "ssh -L localhost:8443:localhost:443 ${USER}@127.0.0.1"
ssh -D 9999 -L localhost:8443:localhost:443 ${USER}@127.0.0.1

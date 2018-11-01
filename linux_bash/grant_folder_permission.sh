#!/bin/bash

# grant read write permission to a user without changing the ownership
setfacl -m u:username:rwx myfolder

# grant the ownership of a folder
sudo chown -R username: directory
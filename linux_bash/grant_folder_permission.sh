#!/bin/bash

# grant all users the read write permission to the directory and sub-directories
sudo chmod -R 0777 /directory

# grant read write permission to a user without changing the ownership
setfacl -m u:username:rwx myfolder

# grant the ownership of a folder
sudo chown -R username: /directory

#!/bin/bash

# go inside the opt directory
cd /opt

# to create a folder named backups
mkdir backups

# go to backups folder
cd backups

# to backup and compress file into .gz
mysqldump -u root -p2486181999j wordpress | gzip > wordpress_$(date '+%Y-%m-%d').sql.gz
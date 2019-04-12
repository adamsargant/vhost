#!/bin/bash

# permissions
if [ "$(whoami)" != "root" ]; then
    echo "Root privileges are required to run this, try running with sudo..."
    exit 2
fi

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
hosts_path="/etc/hosts"
vhosts_path="/etc/apache2/sites-available/"
vhost_skeleton_path="path to your vhosts.skeleton.conf"
apache_root="/var/www/html/"
physical_root="path to directory where your host directories are located"
domain=".dev.local"


# subdomain passed as option?
sub_domain=$1

# prompt if not passed as option
if [ $# -eq 0 ]; then
    read -p "Please enter the desired subdomain: " sub_domain
fi
relative_doc_root=$sub_domain
site_url=$sub_domain$domain

# construct absolute path
absolute_doc_root=$physical_root$relative_doc_root

apache_path=$apache_root$site_url

# create directory if it doesn't exists
if [ ! -d "$absolute_doc_root" ]; then

    # create directory
    `mkdir "$absolute_doc_root/"`

    # create index file
    indexfile="$absolute_doc_root/index.html"
    `touch "$indexfile"`
    echo "<html><head></head><body>Welcome!</body></html>" >> "$indexfile"
    `chown -R user:group "$absolute_doc_root/"`
    `chmod  0664 "$indexfile"`
    echo "Created directory $absolute_doc_root/"
fi

# create symlink
`ln -s  "$absolute_doc_root"/ "$apache_path"`
echo "Created symlink ln -s $absolute_doc_root/ $apache_root$site_url"

# update vhost
vhost=`cat "$vhost_skeleton_path"`
vhost=${vhost//@site_url@/$site_url}
vhost=${vhost//@apache_path@/$apache_path}

`touch $vhosts_path$site_url.conf`
echo "$vhost" > "$vhosts_path$site_url.conf"
echo "Updated vhosts in Apache config"

# update hosts file
echo 127.0.0.1    $site_url >> $hosts_path
echo "Updated the hosts file"

# restart apache
echo "Enabling site in Apache..."
echo `a2ensite $site_url`

echo "Restarting Apache..."
echo `/etc/init.d/apache2 restart`

echo "Process complete, check out the new site at http://$site_url"
echo "located in $absolute_doc_root"

exit 0


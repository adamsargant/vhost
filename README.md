# vhost
Automatically provision virtual hosts on a local LAMP box

  * First you will need to edit the variable physical_root. physical_root is where you are going have the symlink created to so that you can work on your site within your home directory.
  * Then, make sure you edit user and group on line 43
  * Add the vhost directory file to /usr/local/bin/
  * Make the addvhost.sh file executable chmod -x addvhost.sh
  * Finally, add the following function to your .bashrc or .bash_profile file

```
    function addvhost {
        sudo /usr/local/bin/vhost/addvhost.sh $1
    }
```

and once you have re-sourced your bashrc file you can add new vhosts to your local server with the domain  http://xyz.dev.local and a directory at 'physical_root'/xyz. Huzzah.

Caveat: All the above assumes that the LAMP box is already set up to allow symlinks from var/wwww/html to your home directory to work... i.e. the apache user is added to your users group and relevant permision on the directory chain are set. On my current Ubuntu set up I had to modify the permissions of my dropbox directory to 0777 and add www-data to my group.
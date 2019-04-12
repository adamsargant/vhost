# vhost
Automatically provision virtual hosts on a local lamp box

  * First you will need to edit the two variables vhost_skeleton_path and physical_root. physical_root is where you are going have the symlink created to so that you can work on your site within your home directory and vhost_skeleton_path is where you will locate the other file here.
  * Then, make sure you edit user and group on line 43
  * Add the addvhost.sh file to /usr/local/bin/
  * Add the vhosts.skeleton.conf where you wish... I tend to add it to a vhost.skeleton folder in /etc/apache2
  * Finally, add the following function to your .bashrc or .bash_profile file

```
    function addvhost {
        sudo /usr/local/bin/addvhost.sh $1
    }
```

and once you have resourced your bashrc file you can add new vhosts to your local server with the domain  http://xyz.dev.local and a directory at 'physical_root'/xyz. Huzzah.
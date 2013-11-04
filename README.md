# Running Perl workers on Iron.IO

Despite not being listed as an option on their documentation, it is possible to run perl workers on their platform.

# Quick start

## IronWorker (their upload/management tool)

We will need their management tool to upload code.

    gem install iron_worker_ng

## The credentials

 To get it, log in to https://hud.iron.io/dashboard, click on the key-icon and download `iron.json` to this directory

## Our dependency resolution tool

Iron.IO doesn't come with any perl module other than what is in core, so we need to bring in all our dependencies.
For that we will use [Carton](https://metacpan.org/pod/Carton) and list everything we depend on in a `cpanfile`

    $ cpanm -nq Carton   # install carton
    $ carton install     # resolve all dependencies from cpanfile and store in ./local/

## Deploy

    $ iron_worker upload iron-pl.worker
        ------> Creating client
                Project 'ironing-board' with id='5277a2b987a3b90005000044'
        ------> Creating code package
                Found workerfile with path='iron-pl.worker'
                Detected exec with path='iron-pl.pl' and args='{}'
                Merging dir with path='local/lib/perl5' and dest=''
                Code package name is 'iron-pl'
        ------> Uploading code package 'iron-pl'
                Code package uploaded with id='5277af07c7abc62bd5098755' and revision='4'
                Check 'https://hud.iron.io/tq/projects/5277a2b987a3b90005000044/code/5277af07c7abc62bd5098755' for more info

## Add tasks to the queue

    $ iron_worker queue iron-pl -p '{"ironing":"board"}'
        ------> Creating client
                Project 'ironing-board' with id='5277a2b987a3b90005000044'
        ------> Queueing task
                Code package 'iron-pl' queued with id='5277b647d16f933601092a4e'
                Check 'https://hud.iron.io/tq/projects/5277a2b987a3b90005000044/jobs/5277b647d16f933601092a4e' for more info

## Check results

We can either go straight to the web interface using the url listed above or use their management tool:

    $ iron_worker log 5277b647d16f933601092a4e
        ------> Creating client
                Project 'ironing-board' with id='5277a2b987a3b90005000044'
        ------> Getting log for task with id='5277b647d16f933601092a4e'
        Iron-Play v0.0.1
        2013-11-04T14:59:23
        Environment: {
            HOME              "/task",
            LANG              "en_US.UTF-8",
            LD_LIBRARY_PATH   ".:./lib:./__debs__/usr/lib:./__debs__/usr/lib/x86_64-linux-gnu:./__debs__/lib:./__debs__/lib/x86_64-linux-gnu",
            LOGNAME           "nobody",
            MAIL              "/var/mail/nobody",
            OLDPWD            "/task",
            PATH              ".:./bin:./__debs__/usr/bin:./__debs__/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games",
            PWD               "/task",
            SHELL             "/bin/sh",
            SUDO_COMMAND      "/usr/bin/ruby run.rb --sleep 240 -e production -n 4 -j /mnt/iron-jail",
            SUDO_GID          1000,
            SUDO_UID          1000,
            SUDO_USER         "ubuntu",
            TERM              "unknown",
            USER              "nobody",
            USERNAME          "root"
        }
        Arguments: {
            -d         "/task/",
            -e         "production",
            -id        "5277b647d16f933601092a4e",
            -payload   "/task/task_payload.json"
        }
        Payload (/task/task_payload.json): \ {
            ironing   "board"
        }
        Doing work (2): ..
        Done.

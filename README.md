# Perl on IronWorker

This is a working example of running perl on IronWorker.

For the full explanation, check the blog post [Running Perl Workers on Iron.IO](http://blog.carloslima.name/blog/2013/11/05/running-perl-workers-on-iron-dot-io/)

# Get me up and running, fast.

Login to https://hud.iron.io/dashboard, download `iron.json` credential file (the 'key' icon)


    gem install iron_worker_ng
    # rbenv rehash (if you're using rbenv)
    cpanm Carton
    git clone https://github.com/carloslima/iron-play
    cd iron-play
    carton install
    iron_worker upload iron-pl.worker
    iron_worker queue iron-pl -p '{"tags":["iron.io","perl"]}'
    iron_worker log <id from previous command output>

Have a beer. \o/

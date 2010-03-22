## Installation

You can install Typus as a plugin or as a gem.

### Plugin Install

Install from GitHub the latest version which is compatible with **Rails 2.3.4**.

    $ script/plugin install git://github.com/fesplugas/typus.git

To re-install the plugin use the `--force` option.

### Gem Install

Add **Typus** to your <tt>config/environment.rb</tt>.

    config.gem 'typus'

Install the plugin.

    $ sudo rake gems:install
    $ rake gems:unpack

## Running the generator

Once the plugin is installed generate **Typus** files and migrate your database. A `typus_users` table will be created, this is where **Typus** users are stored.

    $ script/generate typus
    $ rake db:migrate

Start the application server, go to <http://0.0.0.0:3000/admin> and follow the instructions.

### Compatibility

Master branch is tested with **Rails 2.3.5** and **Ruby 1.8.7-p249**.

## Available rake tasks

If you installed **Typus** as a plugin you can view the available tasks running:

    $ rake -T typus
    (in /Users/fesplugas/Development/typus_core)
    rake doc:plugins:typus  # Generate documentation for the typus plugin
    rake typus:ckeditor     # Install ckeditor.
    rake typus:misc         # Install acts_as_list, acts_as_tree and paperclip.
    rake typus:roles        # List current roles.
    rake typus:ssl          # Install ssl_requirement.

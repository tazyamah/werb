# Werb

simple ruby web framework(likes naked php).

## Installation

Add this line to your application's Gemfile:

    gem 'werb', :git => 'git@github.com:tazyamah/werb.git'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install werb

## Usage
To start werb server:

    $ werb

or:

    $ bundle exec werb

<!--
To start developing:

    $ werb init

Files and Directories `werb init` creating:

    lib/
      # put your ruby script(s)
    public/
      # put your erb(s)
    Gemfile
    config.rb # web configuaration files.
-->

### Routing

  `http://localhost:3000/path/to/file` -> `werb_root/public/path/to/file.html.erb`


## Contributing

sorry under construction....

<!--
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
-->

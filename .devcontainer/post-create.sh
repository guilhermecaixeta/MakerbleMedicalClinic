#!/bin/bash

# An example of post create file for a devcontainer

# Source ASDF
. /usr/local/asdf/asdf.sh

# Install the version of Bundler specified in Gemfile.lock
if [ -f Gemfile.lock ]; then
    bundler_version=$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1 | tr -d ' ')
    gem install bundler -v "$bundler_version"
fi

# If there's a Gemfile, then run `bundle install`
if [ -f Gemfile ]; then
    if [ -f Gemfile ]; then
    
    echo "Installing gems" 
    gem install rails htmlbeautifier solargraph \
        sorbet rufo tapioca foreman \
        debug ruby-lsp rdbg erb_lint
    
    echo "running bundle"
    bundle install
    
    chmod u+x bin/rails

    echo "initializing sorbet"
    bundle exec srb init

    echo "initializing tapioca"
    bundle exec tapioca init
fi
fi

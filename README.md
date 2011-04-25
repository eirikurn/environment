# EirikurN's Environment

These are config files to set up a system the way I like it.

The structure and installation scripts are derived from Ryan Bates's
excellent [dotfiles repo](https://github.com/ryanb/dotfiles).

## Installation

  git clone git://github.com/eirikurn/environment
  cd environment
  rake install


## Environment

I have tried to maintain varying support for all operating systems and 
bourne-based shells, however my primary working environment is Linux and zsh.

It can be tricky getting all vim bundles to run, especially on Windows.
Generally you'll need a recent vim with ruby support, and compile the
Command-T binaries using rake.


## Features

See aliases in ~/.zsh/aliases

If there are some shell configuration settings which you want secure or 
specific to one system, place it into a ~/.localrc file. This will be 
loaded automatically if it exists.

If you're using git, you'll notice the current branch name shows up in
the prompt while in a git repository.

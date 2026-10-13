======
README
======

This is my current VIM setup. It is not meant to be used by anyone else than
me. It is not meant to deal as a modular environment for anyone. The only thing
that it can deal for is as an example. Feel free to fork as basis for your
setup, while I recommend to just looking into it and get inspiration from it.

-------
Install
-------

1. Clone this Git repo including the plugin submodules::

        git clone --recurse-submodules <url>

   (In an existing clone: ``git submodule update --init``)

2. Link the following files::

        ~/.vim          -> <repo>/
        ~/.vimrc        -> <repo>/vimrc

Plugins live in ``pack/plugins/start/`` and are loaded by Vim's native package
support. Update them with::

        git submodule update --remote --merge

--------------------------
Thanks for inspirations to
--------------------------

- Benjamin Eberlei (https://github.com/beberlei)
- Jakob Westhoff (https://github.com/jakobwesthoff)

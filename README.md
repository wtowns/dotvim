# .vim Files

## Setup Instructions

Clone this repository into your ~/.vim directory:
```bash
git clone git@github.com:wtowns/dotvim ~/.vim
```

Run the setup script:
```bash
~/.vim/setup
```

That's it!  Enjoy Vim.

Also: Don't hesitate to send me a pull request with useful changes!

## Powerline

In order for the Powerline-enabled status line to be rendered correctly, you
will need a patched font.  Follow the instructions located at
https://github.com/Lokaltog/vim-powerline or use a pre-patched font at
https://github.com/Lokaltog/vim-powerline/wiki/Patched-fonts .
Alternatively, you can turn off the custom symbols by adding
``let g:Powerline_symbols = compatible`` to your ``vimrc``.

## Adding Plugins

(Most of) the included vim plugins are managed by Pathogen and are
tracked as submodules.  To add a new plugin, find the url for the
desired plugin's git repository and run the following from your .vim
directory:
```bash
git submodule add $REPOSITORY_URL bundle/$PLUGIN_NAME
./sync-plugins
```
Where $REPOSITORY\_URL is the plugin's public git repository and
$PLUGIN\_NAME is the desired directory name for the plugin.

## Updating

When pulling new updates, there may be new plugins included.  In order to use
them, you'll first need to download them:
```bash
git submodule update --init
```

## Some Useful Commands

Once inside vim, there are far too many custom features available to list here.
Also see the :help pages for the various plugins for instructions on how to
utilize them.  See the "Mappings" section of .vimrc, but here are some personal
commands:

```
<Leader><Leader> : Hide highlighting
<Leader>vv : Open the .vimrc file in the current buffer
<Leader>vt : Open the .vimrc file in a new tab
<Leader>vs : Reload the .vimrc file
<Leader>sr : Search and replace within current file
<Leader>gg : 'Ack -i' a string (must have ack installed in your $PATH)
<Leader>gw : 'Ack -i' the word under the cursor
<Leader>y  : Yank the selected text (or current line) to the Windows clipboard
<Leader>a  : Move to next window
<Leader>n  : Open an empty buffer in a new tab
<Leader>b  : Open FuzzyFinder in buffer mode
<Leader>co : Open quickfix window
<Leader>cc : Close quickfix window
H          : Move left one tab
L          : Move right one tab
Ctrl+h     : Move tab left
Ctrl+l     : Move tab right
Ctrl+p     : Open Ctrl+P window in file mode
jk         : Mapped to <esc> in insert/command modes

(Note: <Leader> defaults to "\")
```

## TODO

* Convert remaining non-pathogen plugins
* Find better solution for optional dependencies (ack, ctags)

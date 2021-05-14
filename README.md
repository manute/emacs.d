emacs.d
=======

Clone this repo into ~/.emacs.d


# Mac OSX

It´s recommendable the version of emacs >= 28 and with native JSON support (for lsp perfomance)

```shell
brew tap daviderestivo/emacs-head
brew install emacs-head@28 --with-cocoa --with-imagemagick --with-jansson --with-modern-icon-sexy-v1
```

# Linux

```bash
sudo apt-get install emacs
```


# Daemon

The empty -a parameter means that if no daemon exists, it should start one in the background and retry.
The -t option means terminal mode should be used reusing an existing daemon.
"$@"means that when the script is invoked with a path as command-line

```
alias em='emacsclient -a "" -t "$@"'
```

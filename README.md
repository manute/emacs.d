emacs.d
=======

- clone this repo into ~/.emacs.d


Mac OSX
--------

It´s recommendable the version of emacs >= 24.4 (because some packages need queue-0.1.1 as dependency)

``` brew install emacs --HEAD --use-git-head --cocoa --with-gnutls ```

Linux
-------

```bash
sudo apt-get install emacs
```

Modes dependencies
------------------

 * clojure-mode

   * [lein](http://leiningen.org/)
   *  ~/.lein/profiles.clj : (check out versions!)

    ```clojure
      {:user
        {:plugins [[lein-exec "0.3.1"]
                   [cider/cider-nrepl "0.9.0-SNAPSHOT"]
                   [lein-pprint "1.1.1"]
                   [venantius/ultra "0.3.2"]]
          :ultra {:color-scheme :solarized_dark}
                  :dependencies [[org.clojure/clojure "1.6.0"]
                                 [org.clojure/tools.nrepl "0.2.7"]]}}
    ```

 * python-mode

   * [virtualenvwrapper](http://virtualenvwrapper.readthedocs.org/en/latest/)

 * ruby-mode

   * [rbenv](https://github.com/sstephenson/rbenv)

 * groovy-mode

   * [gvm](http://gvmtool.net/)

 * go-mode

   * [Path of workspace](http://golang.org/doc/code.html#GOPATH)
   * [Autocompletion](https://github.com/nsf/gocode)
   * [goimports](https://godoc.org/golang.org/x/tools/cmd/goimports)

 * racket-mode

   * [racket](http://docs.racket-lang.org/getting-started/index.html)

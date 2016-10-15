## Purpose

This plugin makes available the control functions defined by the [Figwheel](https://github.com/bhauman/lein-figwheel) REPL as vimscript functions.

This enables you to do a few things:

### Start Figwheel from vim.
  * `:FigwheelStart` will start the default cljsbuild.
  * `:FigwheelStart dev devcards` will start the cljsbuilds defined with the "dev" and "devcards" ids.

![FigwheelStart image](http://i.imgur.com/rISbtXw.png)

### Stop Figwheel from vim.
  * `:FighwheelStop` will stop Figwheel autobuild

![FigwheelStop image](http://i.imgur.com/SwNJPz4.png)

### Switch Figwheel from vim.
  * `:FigwheelSwitch devcards` will switch to the build defined with the "devcards" id.

![FigwheelSwitch image](http://i.imgur.com/MLtB77h.gifv)
### Reset Figwheel from vim.
### Clean Figwheel from vim.
### Get quick access to Fighwheels status.

![Figwheel status](http://i.imgur.com/Wq9HHgW.png)

## Installation

Install using your favourite plugin manager,
I use [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'markwoodhall/vim-figwheel'
```

This plugin makes use of [vim-fireplace](https://github.com/tpope/vim-fireplace) so you will need to install this as well.

```vim
Plug 'tpope/vim-fireplace'

```

## Usage

The following functions are made available:

```vim
:FigwheelStart  " Starts the default Figwheel build or an optional list of builds
:FigwheelSwitch " Switch to a Figwheel build
:FigwheelClean  " Deletes compiled cljs target files for the specfied builds
:FigwheelBuild  " Builds a fighweel build once
```

```vim
:FigwheelReset  " Stops, cleans and starts Figwheel autobuild
:FigwheelStop   " Stops Figwheel autobuild
:FigwheelStatus " Gets the current state of Figwheel
:Figgieback     " Piggiebacks onto the Figwheel browser REPL
```

The above functions map to the control functions defined by the Figwheel REPL. You can read more [here](https://github.com/bhauman/lein-figwheel)

```clojure
 (stop-autobuild)            ;; stops Figwheel autobuilder
 (start-autobuild [id ...])  ;; starts autobuilder focused on optional ids
 (switch-to-build id ...)    ;; switches autobuilder to different build
 (reset-autobuild)           ;; stops, cleans, and starts autobuilder
 (build-once [id ...])       ;; builds source one time
 (clean-builds [id ..])      ;; deletes compiled cljs target files
 (fig-status)                ;; displays current state of system
 ```

## License
Copyright © Mark Woodhall. Distributed under the same terms as Vim itself. See `:help license`

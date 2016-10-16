## Purpose

This plugin makes available the control functions defined by the [Figwheel](https://github.com/bhauman/lein-figwheel) REPL as vimscript functions.

This enables you to do a few things:

### Start Figwheel from vim.
  * `:FigwheelStart` will start the default cljsbuild.
  * `:FigwheelStart dev, devcards` will start the cljsbuilds defined with the "dev" and "devcards" ids.

Note the space between "dev," and "devcards" above. When specifying multiple build arguments to suitable functions they should
always follow this format. For now.

![FigwheelStart image](http://i.imgur.com/rISbtXw.png)

### Stop Figwheel from vim.
  * `:FighwheelStop` will stop Figwheel autobuild

![FigwheelStop image](http://i.imgur.com/SwNJPz4.png)

### Switch Figwheel from vim.
  * `:FigwheelSwitch devcards` will switch to the build defined with the "devcards" id.

![FigwheelSwitch image](http://i.imgur.com/MLtB77h.png)
### Clean Figwheel from vim.
  * `:FigwheelClean devcards` will clean the build defined with the "devcards" id.

![FigwheelClean image](http://i.imgur.com/vVWTqW1.png)
### Get quick access to Fighwheels status in vim.

![Figwheel status](http://i.imgur.com/Wq9HHgW.png)

### Get list of Figwheel build ids in vim

![FigwheelBuilds image](http://i.imgur.com/3AJ84B5.png)

## Installation

Install using your favourite plugin manager,
I use [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'markwoodhall/vim-figwheel'
```

## Requirements

This plugin requires a Figwheel project, perhaps created with `lein new figwheel`, and the Fighweel version must be at least `0.5.8`.

This plugin makes use of [vim-fireplace](https://github.com/tpope/vim-fireplace) so you will need to install this as well.

```vim
Plug 'tpope/vim-fireplace'

```

As is typical for [vim-fireplace](https://github.com/tpope/vim-fireplace) you will need a running REPL, `lein repl`.

## Usage

The following functions are made available:

```vim
:FigwheelStart  " Starts the default Figwheel build or an optional list of builds
:FigwheelSwitch " Switch to a Figwheel build
:FigwheelClean  " Deletes compiled cljs target files for the specfied builds
:FigwheelBuild  " Builds a fighweel build once
```

```vim
:FigwheelBuilds " Gets a list of Figwheel build ids
:FigwheelReset  " Stops, cleans and starts Figwheel autobuild
:FigwheelStop   " Stops Figwheel autobuild
:FigwheelStatus " Gets the current state of Figwheel
:Figgieback     " Piggiebacks onto the Figwheel browser REPL
```

## Tips

Use `Figwheel*` commands when in a Clojure buffer, use Figgieback in a ClojureScript buffer to enable the use of Figwheels ClojureScript REPL on top of a regular nREPL session.

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

if exists('g:loaded_figwheel') || &cp
  finish
endif
let g:loaded_figwheel = 1

if !exists("*fireplace#eval")
  echoerr "vim-figwheel requires the vim-fireplace plugin but it is not currently loaded or installed."
  finish
endif

function! s:Start(...)
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (when (not (figwheel-sidecar.repl-api/figwheel-running?)) (figwheel-sidecar.repl-api/start-figwheel!)))"
  if a:0 > 0 && a:1 != ''
    let evalString = evalString."(figwheel-sidecar.repl-api/start-autobuild ".join(a:000, ' ').")"
  endif
  execute "Eval ".evalString
endfunction

function! s:Stop()
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (when (figwheel-sidecar.repl-api/figwheel-running?)) (figwheel-sidecar.repl-api/stop-autobuild))"
  execute "Eval ".evalString
endfunction

function! s:Switch(...)
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (when (not (figwheel-sidecar.repl-api/figwheel-running?)) (figwheel-sidecar.repl-api/start-figwheel!)))"
  if a:0 > 0 && a:1 != ''
    let evalString = evalString."(figwheel-sidecar.repl-api/switch-to-build ".join(a:000, ' ').")"
  endif
  execute "Eval ".evalString
endfunction

function! s:Reset()
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (figwheel-sidecar.repl-api/reset-autobuild))"
  execute "Eval ".evalString
endfunction

function! s:Clean(...)
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (when (not (figwheel-sidecar.repl-api/figwheel-running?)) (figwheel-sidecar.repl-api/start-figwheel!)))"
  if a:0 > 0 && a:1 != ''
    let evalString = evalString."(figwheel-sidecar.repl-api/clean-builds ".join(a:000, ' ').")"
  endif
  execute "Eval ".evalString
endfunction

function! s:Build(...)
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (when (not (figwheel-sidecar.repl-api/figwheel-running?)) (figwheel-sidecar.repl-api/start-figwheel!)))"
  if a:0 > 0 && a:1 != ''
    let evalString = evalString."(figwheel-sidecar.repl-api/build-once ".join(a:000, ' ').")"
  endif
  execute "Eval ".evalString
endfunction

function! s:Status()
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (when (not (figwheel-sidecar.repl-api/figwheel-running?)) (figwheel-sidecar.repl-api/start-figwheel!)))"
  let evalString = evalString."(figwheel-sidecar.repl-api/fig-status)"
  execute "Eval ".evalString
endfunction

function! s:Figgieback()
  execute "Piggieback (do (require '[figwheel-sidecar.repl-api]) (figwheel-sidecar.repl-api/repl-env))"
endfunction


autocmd FileType clojure command! -nargs=* -buffer FigwheelStart :exe s:Start(<q-args>)
autocmd FileType clojure command! -nargs=* -buffer FigwheelSwitch :exe s:Switch(<q-args>)
autocmd FileType clojure command! -nargs=* -buffer FigwheelClean :exe s:Clean(<q-args>)
autocmd FileType clojure command! -nargs=* -buffer FigwheelBuild :exe s:Build(<q-args>)

autocmd FileType clojure command! -buffer FigwheelReset :exe s:Reset()
autocmd FileType clojure command! -buffer FigwheelStop :exe s:Stop()
autocmd FileType clojure command! -buffer FigwheelStatus :exe s:Status()
autocmd FileType clojure command! -buffer Figgieback :exe s:Figgieback()

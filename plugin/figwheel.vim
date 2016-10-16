if exists('g:loaded_figwheel') || &cp
  finish
endif
let g:loaded_figwheel = 1

if !exists("*fireplace#eval")
  echoerr "vim-figwheel requires the vim-fireplace plugin but it is not currently loaded or installed."
  finish
endif

function! s:Start(buildsString)
  let builds = split(a:buildsString, ", ")
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (when (not (figwheel-sidecar.repl-api/figwheel-running?)) (figwheel-sidecar.repl-api/start-figwheel!)))"
  if len(builds) > 0
    let evalString = evalString."(figwheel-sidecar.repl-api/start-autobuild \"".join(builds, '" "')."\")"
  endif
  execute "Eval ".evalString
endfunction

function! s:Stop()
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (when (figwheel-sidecar.repl-api/figwheel-running?)) (figwheel-sidecar.repl-api/stop-autobuild))"
  execute "Eval ".evalString
endfunction

function! s:Switch(buildsString)
  let builds = split(a:buildsString, ", ")
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (when (not (figwheel-sidecar.repl-api/figwheel-running?)) (figwheel-sidecar.repl-api/start-figwheel!)))"
  if len(builds) > 0
    let evalString = evalString."(figwheel-sidecar.repl-api/switch-to-build \"".join(builds, '" "')."\")"
  endif
  execute "Eval ".evalString
endfunction

function! s:Reset()
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (figwheel-sidecar.repl-api/reset-autobuild))"
  execute "Eval ".evalString
endfunction

function! s:Clean(buildsString)
  let builds = split(a:buildsString, ", ")
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (when (not (figwheel-sidecar.repl-api/figwheel-running?)) (figwheel-sidecar.repl-api/start-figwheel!)))"
  if len(builds) > 0
    let evalString = evalString."(figwheel-sidecar.repl-api/clean-builds \"".join(builds, '" "')."\")"
  endif
  execute "Eval ".evalString
endfunction

function! s:Builds()
  let evalString = "(do (require '[figwheel-sidecar.system]) (vec (keys (figwheel-sidecar.system/get-project-builds))))"
  let figwheelBuilds = fireplace#eval(evalString)
  echomsg figwheelBuilds
  return "'".figwheelBuilds."'"
endfunction

function! s:Status()
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (when (not (figwheel-sidecar.repl-api/figwheel-running?)) (figwheel-sidecar.repl-api/start-figwheel!)))"
  let evalString = evalString."(figwheel-sidecar.repl-api/fig-status)"
  execute "Eval ".evalString
endfunction

function! s:Build(buildsString)
  let builds = split(a:buildsString, ", ")
  let evalString = "(do (require '[figwheel-sidecar.repl-api]) (when (not (figwheel-sidecar.repl-api/figwheel-running?)) (figwheel-sidecar.repl-api/start-figwheel!)))"
  if len(builds) > 0
    let evalString = evalString."(figwheel-sidecar.repl-api/start-autobuild \"".join(builds, '" "')."\")"
  endif
  execute "Eval ".evalString
endfunction

function! s:Figgieback()
  execute "Piggieback (do (require '[figwheel-sidecar.repl-api]) (figwheel-sidecar.repl-api/repl-env))"
endfunction

function! s:BuildsComplete(A, L, P) abort
  if strpart(a:L, 0, a:P) !~# ' [[:alnum:]-]\+ '
    let cmds = s:Builds()
    let cmds = substitute(cmds, " ", ", ", "g")
    let cmds = eval(cmds)
    return filter(eval(cmds), 'strpart(v:val, 0, strlen(a:A)) ==# a:A')
  endif
endfunction

autocmd FileType clojure command! -nargs=* -complete=customlist,s:BuildsComplete -buffer FigwheelStart :exe s:Start(<q-args>)
autocmd FileType clojure command! -nargs=* -complete=customlist,s:BuildsComplete -buffer FigwheelSwitch :exe s:Switch(<q-args>)
autocmd FileType clojure command! -nargs=* -complete=customlist,s:BuildsComplete -buffer FigwheelClean :exe s:Clean(<q-args>)
autocmd FileType clojure command! -nargs=* -complete=customlist,s:BuildsComplete -buffer FigwheelBuild :exe s:Build(<q-args>)

autocmd FileType clojure command! -buffer FigwheelReset :exe s:Reset()
autocmd FileType clojure command! -buffer FigwheelStop :exe s:Stop()
autocmd FileType clojure command! -buffer FigwheelBuilds :exe s:Builds()
autocmd FileType clojure command! -buffer FigwheelStatus :exe s:Status()
autocmd FileType clojure command! -buffer Figgieback :exe s:Figgieback()

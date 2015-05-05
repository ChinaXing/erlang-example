-module(sum).
-export([sum/2]).
-on_load(init/0).

init() ->
    ok = erlang:load_nif("./sum_nif",0).

sum(_X, _Y) ->
    exit(nif_library_not_loaded).

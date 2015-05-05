-module(sum).
-export([start/1, stop/0, init/1]).
-export([sum/2]).

%% This module run as a server, which proxy the request Message to Port driver.

start(SharedLib) ->
    case erl_ddll:load_driver(".", SharedLib) of
	ok -> ok;
	{error, already_loaded} -> ok;
	_ -> exit({error, could_not_load_driver})
    end,
    spawn(?MODULE, init, [SharedLib]).

init(SharedLib) ->
    register(sum, self()),
    Port = open_port({spawn_driver, SharedLib}, [binary]),
    loop(Port).

stop() ->
    sum ! stop.
	    
sum(X, Y) ->
    call_port({sum, X, Y}).

call_port(Msg) ->
    sum ! {call, self(), Msg},
    receive
	{sum, Result} ->
	    Result
    end.

loop(Port) ->
    receive
	{call, Caller, Msg} ->
	    Port ! {self(), {command, encode(Msg)}},
	    receive
		{Port, {data, Data}} ->
		    Caller ! {sum, decode(Data)}
	    end,
	    loop(Port);
	stop ->
	    Port ! {self(),close},
	    receive
		{Port, closed} ->
		    exit(normal)
	    end;
	{'EXIT', Port, Reason} ->
	    io:format("~p~n", [Reason]),
	    exit(port_terminated)
    end.

encode({sum, X, Y}) ->
    <<1:8,X:32,Y:32>>.

decode(<<Int:32>>) -> 
    Int.


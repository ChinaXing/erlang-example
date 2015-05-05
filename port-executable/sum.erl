-module(sum).
-export([start/1, stop/0, init/1]).
-export([sum/2]).

start(Executable) ->
    spawn(?MODULE, init, [Executable]).

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

init(Executable) ->
    register(sum, self()),
    process_flag(trap_exit, true),
    Port = open_port({spawn, Executable}, [{packet, 2}, binary]),
    loop(Port).

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
	    Port ! {self(), close},
	    receive
		{Port, closed} ->
		    exit(normal)
	    end;
	{'EXIT', Port, Reason} ->
	    exit({port_terminated,Reason})
    end.

encode({sum, X, Y}) ->
     <<1,X:32,Y:32>>.

decode(<<Sum:32>>) ->
    Sum.

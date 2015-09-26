%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. Sep 2015 2:48 PM
%%%-------------------------------------------------------------------
-module(my_server).
-author("IvoDukov").

%% API
-export([
  start/2,
  start_link/2,
  call/2,
  cast/2,
  reply/2
]).


%%% Public API
start(Module, InitialState) ->
  spawn(fun() -> init(Module, InitialState) end).

start_link(Module, InitialState) ->
  spawn_link(fun() -> init(Module, InitialState) end).

call(Pid, Msg) ->
  Ref = erlang:monitor(process, Pid),
  Pid ! {sync, self(), Ref, Msg},
  receive
    {Ref, Reply} ->
      erlang:demonitor(Ref, [flush]),
      Reply;

    {'DOWN', Ref, process, Pid, Reason} ->
      erlang:error(Reason)
  after 5000 ->
    erlang:error(timeout)
  end.

cast(Pid, Msg) ->
  Pid ! {async, Msg},
  ok.

reply({Pid, Ref}, Reply) ->
  Pid ! {Ref, Reply}.



%%% Private stuff
init(Module, InitialState) ->
  loop(Module, Module:init(InitialState)).

loop(Module, State) ->
  receive
    {async, Msg} ->
      loop(Module, Module:handle_cast(Msg, State));
    {sync, Pid, Ref, Msg} ->
      loop(Module, Module:handle_call(Msg, {Pid, Ref}, State))
  end.
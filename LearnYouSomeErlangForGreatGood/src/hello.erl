%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. Sep 2015 7:30 PM
%%%-------------------------------------------------------------------
-module(hello).
-author("IvoDukov").

%% API
-export([
  hello_world/1,
  add/2
]).

hello_world(Name) ->
  io:fwrite("hello, ~s.\n", [Name]).

add(A, B) ->
  Result = A + B,
  io:format("Result: ~w~n", [Result]).

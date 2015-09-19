%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. Sep 2015 10:49 PM
%%%-------------------------------------------------------------------
-module(functions).
-author("IvoDukov").

%% API
-export([
  valid_time/1
]).

valid_time({Date = {Y, M, D}, Time = {H, Min, S}}) when
    %% Guards
    is_integer(Y), Y >= 0, Y =< 2015,
    is_integer(M), M >= 1, M =< 12,
    is_integer(D), D >= 1, D =< 31,
    is_integer(H), H >= 0, H =< 24,
    is_integer(Min), Min >= 0, Min =< 60,
    is_integer(S), S >= 0, S =< 60 ->

  io:format("The Date tuple (~p) says today is: ~p/~p/~p,~n",[Date,Y,M,D]),
  io:format("The Time tuple (~p) indicates: ~p:~p:~p.~n", [Time,H,Min,S]);

valid_time(_) ->
  io:format("Stop feeding me wrong data!~n").
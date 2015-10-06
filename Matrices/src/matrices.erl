%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. Sep 2015 11:35 AM
%%%-------------------------------------------------------------------
-module(matrices).
-author("IvoDukov").

%% API
-export([
  create_clist/1,
  create_inc_clist/1,
  print_clist/1
]).

%% Create coordinates list
create_clist(N) -> create_clist(N, N, N, []).

create_clist(1, 0, _Size, List) ->
  List;
create_clist(N, 0, Size, List) ->
  create_clist(N - 1, Size, Size, List);
create_clist(N, M, Size, List) ->
  create_clist(N, M - 1, Size, [{N - 1, M - 1, 0} | List]).

%% Print coordinates list
print_clist([]) -> io:fwrite("~n", []);
print_clist([{0, 0, Value} | Tail]) ->
  io:fwrite("~2..0B ", [Value]), print_clist(Tail);
print_clist([{_, 0, Value} | Tail]) ->
  io:fwrite("~n~2..0B ", [Value]), print_clist(Tail);
print_clist([{_, _, Value} | Tail]) ->
  io:fwrite("~2..0B ", [Value]), print_clist(Tail).

%% Create incremental value coordinates list
create_inc_clist(N) -> create_inc_clist(N, N, N, N * N, []).

create_inc_clist(1, 0, _Size, _X, List) ->
  List;
create_inc_clist(N, 0, Size, X, List) ->
  create_inc_clist(N - 1, Size, Size, X, List);
create_inc_clist(N, M, Size, X, List) ->
  create_inc_clist(N, M - 1, Size, X - 1, [{N - 1, M - 1, X} | List]).
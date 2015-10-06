%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Oct 2015 8:25 PM
%%%-------------------------------------------------------------------
-module(insertion_sort).
-author("IvoDukov").

%% API
-export([
  sort/1
]).

sort(List) when is_list(List) ->
  sort(List, []).

sort([], Sorted) -> Sorted;
sort([Head | Tail], Sorted) ->
  sort(Tail, insert(Head, Sorted)).

insert(X, []) -> [X];
insert(X, Sorted) when X =< hd(Sorted) ->
  [X | Sorted];
insert(X, [Head | Tail]) ->
  [Head | insert(X, Tail)].

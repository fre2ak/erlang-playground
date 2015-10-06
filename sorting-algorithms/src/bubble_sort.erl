%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Oct 2015 8:07 PM
%%%-------------------------------------------------------------------
-module(bubble_sort).
-author("IvoDukov").

%% API
-export([
  sort/1,
  sort2/1
]).


%% First variation
sort([]) -> [];
sort(List) when is_list(List) ->
  sort(List, []).

sort([X], Sorted) ->
  [X | Sorted];
sort(List, Sorted) ->
  [Max | Rest] = bubble_move(List, []),
  sort(Rest, [Max | Sorted]).

bubble_move([X], Rest) ->
  [X | Rest];
bubble_move([X, Y | Tail], Rest) ->
  case X > Y of
    true  -> bubble_move([X | Tail], [Y | Rest]);
    false -> bubble_move([Y | Tail], [X | Rest])
  end.


%% Second variation
sort2(List) ->
  sort2(List, [], true).

sort2([], List, true) ->
  lists:reverse(List);
sort2([], List, false) ->
  sort2(lists:reverse(List), [], true);
sort2([X, Y | T], List, _) when X > Y ->
  sort2([X | T], [Y | List], false);
sort2([X | T], L, Halt) ->
  sort2(T, [X | L], Halt).
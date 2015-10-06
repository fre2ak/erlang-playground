%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Oct 2015 1:49 PM
%%%-------------------------------------------------------------------
-module(quick_sort_with_partition).
-author("IvoDukov").

%% API
-export([
  sort/1
]).

sort([]) -> [];
sort([Head | Tail]) ->
  {Less, Greater} = partition(Tail, Head, [], []),
  sort(Less) ++ [Head] ++ sort(Greater).

partition([], _Pivot, Less, Greater) ->
  {Less, Greater};
partition([Head | Tail], Pivot, Less, Greater) ->
  case Head > Pivot of
    true  -> partition(Tail, Pivot, Less, Greater ++ [Head] );
    false -> partition(Tail, Pivot, Less ++ [Head] , Greater)
  end.
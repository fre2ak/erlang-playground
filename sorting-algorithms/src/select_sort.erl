%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Oct 2015 8:35 PM
%%%-------------------------------------------------------------------
-module(select_sort).
-author("IvoDukov").

%% API
-export([
  sort/1
]).

sort([]) -> [];
sort(List) -> sort(List, []).

sort([], Sorted) -> Sorted;
sort([Head | Tail], Sorted) ->
  {Max, Rest} = select_max(Tail, Head, []),
  sort(Rest, [Max | Sorted]).

select_max([], Max, Rest) ->
  {Max, Rest};
select_max([Head | Tail], Max, Rest) when Head < Max ->
  select_max(Tail, Max, [Head | Rest]);
select_max([Head | Tail], Max, Rest) ->
  select_max(Tail, Head, [Max | Rest]).
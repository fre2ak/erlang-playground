%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Oct 2015 8:31 PM
%%%-------------------------------------------------------------------
-module(merge_sort).
-author("IvoDukov").

%% API
-export([
  sort/1
]).

sort([]) -> [];
sort(List) when length(List) =< 1 -> List;
sort(List) ->
  {Left, Right} = lists:split(length(List) div 2, List),
  lists:merge(sort(Left), sort(Right)).
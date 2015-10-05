%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. Oct 2015 11:01 PM
%%%-------------------------------------------------------------------
-module(quick_sort).
-author("IvoDukov").

%% API
-export([
  sort/1
]).

sort([]) -> [];
sort([P | T]) ->
  sort([X || X <- T, X < P]) ++ [P] ++ sort([X || X <- T, X >= P]).
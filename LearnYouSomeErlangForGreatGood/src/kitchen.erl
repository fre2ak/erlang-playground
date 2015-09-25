%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. Sep 2015 12:55 AM
%%%-------------------------------------------------------------------
-module(kitchen).
-author("IvoDukov").

%% API
-compile(export_all).

start(FoodList) ->
  spawn(?MODULE, fridge, [FoodList]).

store(Pid, Food) ->
  Pid ! {self(), {store, Food}},
  receive
    {Pid, Msg} -> Msg
  after 3000 ->
    timeout
  end.

take(Pid, Food) ->
  Pid ! {self(), {take, Food}},
  receive
    {Pid, Msg} -> Msg
  after 3000 ->
    timeout
  end.

fridge(FoodList) ->
  receive
    {From, {store, Food}} ->
      From ! {self(), ok},
      fridge([Food | FoodList]);
    {From, {take, Food}} ->
      case lists:member(Food, FoodList) of
        true ->
          From ! {self(), {ok, Food}},
          fridge(lists:delete(Food, FoodList));
        false ->
          From ! {self(), not_found},
          fridge(FoodList)
      end;
    terminate ->
      ok
  end.
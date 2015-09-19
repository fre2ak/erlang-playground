%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Sep 2015 8:49 AM
%%%-------------------------------------------------------------------
-module(hofuns).
-author("IvoDukov").

%% API
-export([
  increment/1,
  decrement/1,
  map/2,
  incr/1,
  decr/1,
  mult/1,
  devi/1,
  even/1,
  old_men/1,
  filter/2,
  maxc/1,
  minc/1,
  sum/1,
  fold/3,
  reverse/1,
  mapf/2,
  filterf/2
]).

%% Increment values in list
increment([]) -> [];
increment([Head | Tail]) -> [Head + 1 | increment(Tail)].

%% Decrement values in list
decrement([]) -> [];
decrement([Head | Tail]) -> [Head - 1 | decrement(Tail)].

%% Map function
map(_, []) -> [];
map(Function, [Head | Tail]) -> [Function(Head) | map(Function, Tail)].

%% Simple + - * / fuctions
incr(X) -> X + 1.
decr(X) -> X - 1.
mult(X) -> X * 1.
devi(X) -> X / 1.

%% Even numbers
even(L) -> lists:reverse(even(L, [])).

even([], Acc) -> Acc;
even([Head | Tail], Acc) when Head rem 2 == 0 -> even(Tail, [Head | Acc]);
even([_ | Tail], Acc) -> even(Tail, Acc).

%% Men older than 60
old_men(L) -> lists:reverse(old_men(L, [])).

old_men([], Acc) -> Acc;
old_men([Person = {male, Age}  | People], Acc) when Age > 60 ->
  old_men(People, [Person | Acc]);
old_men([_ | People], Acc) -> old_men(People, Acc).

%% Filter
filter(Pred, L) -> lists:reverse(filter(Pred, L, [])).

filter(_, [], Acc) -> Acc;
filter(Pred, [Head | Tail], Acc) ->
  case Pred(Head) of
    true  -> filter(Pred, Tail, [Head | Acc]);
    false -> filter(Pred, Tail, Acc)
  end.

%% Max
maxc([Head | Tail]) -> maxc(Tail, Head).

maxc([], Max) -> Max;
maxc([Head | Tail], Max) when Head > Max -> maxc(Tail, Head);
maxc([_ | Tail], Max) -> maxc(Tail, Max).

%% Min
minc([Head | Tail]) -> minc(Tail, Head).

minc([], Min) -> Min;
minc([Head | Tail], Min) when Head < Min -> minc(Tail, Head);
minc([_ | Tail], Min) -> minc(Tail, Min).

%% Sum
sum(List) -> sum(List, 0).

sum([], Sum) -> Sum;
sum([Head | Tail], Sum) -> sum(Tail, Head + Sum).

%% Fold
fold(_, Start, []) -> Start;
fold(Function, Start, [Head | Tail]) ->
  fold(Function, Function(Head, Start), Tail).

%% Reverse with fold
reverse(List) ->
  fold(fun(X, Acc) -> [X | Acc] end, [], List).

%% Map with fold
mapf(Function, List) ->
  reverse(fold(fun(X, Acc) -> [Function(X) | Acc] end, [], List)).

%% Filter with fold
filterf(Pred, L) ->
  Function = fun(X, Acc) ->
    case Pred(X) of
      true  -> [X | Acc];
      false -> Acc
    end
  end,
  reverse(fold(Function, [], L)).
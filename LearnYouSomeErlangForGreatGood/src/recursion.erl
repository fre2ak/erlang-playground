%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Sep 2015 9:59 PM
%%%-------------------------------------------------------------------
-module(recursion).
-author("IvoDukov").

%% API
-export([
  fac/1,
  len/1,
  tail_fac/1,
  tail_len/1,
  dublicate/2,
  tail_dublicate/2,
  tail_reverse/1,
  sublist/2,
  tail_sublist/2,
  zip/2,
  tail_zip/2,
  lenient_zip/2,
  tail_lenient_zip/2,
  quicksort/1,
  lc_quicksort/1
]).

%% Normal recursive factorial
fac(0) -> 1;
fac(N) when N > 0 -> N * fac(N - 1).

%% Tail recursive factorial
tail_fac(N) -> tail_fac(N, 1).

tail_fac(0, Acc) -> Acc;
tail_fac(N, Acc) when N > 0 -> tail_fac(N - 1, N * Acc).

%% Normal length function
len([]) -> 0;
len([_ | T]) -> 1 + len(T).

%% Tail recursive length function
tail_len(L) -> tail_len(L, 0).

tail_len([], Acc) -> Acc;
tail_len([_ | T], Acc) -> tail_len(T, Acc + 1).

%% Normal dublicate function
dublicate(0, _) -> [];
dublicate(N, Term) when N > 0 -> [Term | dublicate(N - 1, Term)].

%% Tail recursive dublicate function
tail_dublicate(N, Term) -> tail_dublicate(N, Term, []).

tail_dublicate(0, _, List) -> List;
tail_dublicate(N, Term, List) when N > 0 ->
  tail_dublicate(N - 1, Term, [Term | List]).

%% Tail recursive reverse function
tail_reverse(List) -> tail_reverse(List, []).

tail_reverse([], Acc) -> Acc;
tail_reverse([Head | Tail], Acc) ->
  tail_reverse(Tail, [Head | Acc]).

%% Normal sublist function
sublist(_, 0) -> [];
sublist([], _) -> [];
sublist([Head | Tail], N) when N > 0 ->
  [Head | sublist(Tail, N - 1)].

%% Tail recursive sublist function
tail_sublist(List, N) -> tail_reverse(tail_sublist(List, N, [])).

tail_sublist(_, 0, SubList) -> SubList;
tail_sublist([], _, SubList) -> SubList;
tail_sublist([Head | Tail], N, SubList) when N > 0 ->
  tail_sublist(Tail, N - 1, [Head | SubList]).

%% Normal zip function
zip([], []) -> [];
zip([X | Xs], [Y | Ys]) -> [{X, Y} | zip(Xs, Ys)].

%% Tail recursive zip function
tail_zip(X, Y) -> tail_reverse(tail_zip(X, Y, [])).

tail_zip([], [], Acc) -> Acc;
tail_zip([X | Xs], [Y | Ys], Acc) ->
  tail_zip(Xs, Ys, [{X, Y} | Acc]).

%% Lenient zip function
lenient_zip([], _) -> [];
lenient_zip(_, []) -> [];
lenient_zip([X | Xs], [Y | Ys]) -> [{X, Y} | lenient_zip(Xs, Ys)].

%% Tail recursive lenient zip function
tail_lenient_zip(X, Y) -> tail_reverse(tail_lenient_zip(X, Y, [])).

tail_lenient_zip([], _, Acc) -> Acc;
tail_lenient_zip(_, [], Acc) -> Acc;
tail_lenient_zip([X | Xs], [Y | Ys], Acc) ->
  tail_lenient_zip(Xs, Ys, [{X, Y} | Acc]).

%% Quicksort
quicksort([]) -> [];
quicksort([Pivot | Rest]) ->
  {Smaller, Larger} = partition(Pivot, Rest, [], []),
  quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).

partition(_, [], Smaller, Larger) -> {Smaller, Larger};
partition(Pivot, [Head | Tail], Smaller, Larger) ->
  if Head =< Pivot -> partition(Pivot, Tail, [Head | Smaller], Larger);
    Head > Pivot -> partition(Pivot, Tail, Smaller, [Head | Larger])
  end.

%% List comprehensions quicksort
lc_quicksort([]) -> [];
lc_quicksort([Pivot | Rest]) ->
  lc_quicksort([Smaller || Smaller <- Rest, Smaller =< Pivot])
  ++ [Pivot] ++
  lc_quicksort([Larger || Larger <- Rest, Larger > Pivot]).
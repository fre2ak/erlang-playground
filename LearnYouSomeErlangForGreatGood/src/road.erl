%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. Sep 2015 9:31 PM
%%%-------------------------------------------------------------------
-module(road).
-author("IvoDukov").

%% API
-compile(export_all).

main([FileName]) ->
  {ok, Bin} = file:read_file(FileName),
  Map = parse_map(Bin),
  io:format("~p~n", [optimal_path(Map)]),
  erlang:halt().

%% Transform a string into readable map of triples
parse_map(Bin) when is_binary(Bin) ->
  parse_map(binary_to_list(Bin));
parse_map(Str) when is_list(Str) ->
  Values = [list_to_integer(X) || X <- string:tokens(Str, "\r\n\t ")],
  group_vals(Values, []).

group_vals([], Acc) ->
  lists:reverse(Acc);
group_vals([A, B, X | Rest], Acc) ->
  group_vals(Rest, [{A, B, X} | Acc]).

%% actual problem solving
%% change triples of the form {A, B, X}
%% where A, B, X are distances and a, b, x are possible paths
%% to the form {DistanceSum, PathList}.
shortest_step({A, B, X}, {{DistanceA, PathA}, {DistanceB, PathB}}) ->
  OptA1 = {DistanceA + A, [{a, A} | PathA]},
  OptA2 = {DistanceB + B + X, [{x, X}, {b, B} | PathB]},
  OptB1 = {DistanceB + B, [{b, B} | PathB]},
  OptB2 = {DistanceA + X, [{x, X}, {a, A} | PathA]},
  {erlang:min(OptA1, OptA2), erlang:min(OptB1, OptB2)}.

%% Picks the best of all paths
optimal_path(Map) ->
  {A, B} = lists:foldl(fun shortest_step/2, {{0, []}, {0, []}}, Map),
  {_Dist, Path} = if hd(element(2, A)) =/= {x, 0} -> A;
                    hd(element(2, B)) =/= {x, 0} -> B
                  end,
  lists:reverse(Path).
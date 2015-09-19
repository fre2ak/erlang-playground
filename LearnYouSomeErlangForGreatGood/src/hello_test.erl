%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. Sep 2015 7:34 PM
%%%-------------------------------------------------------------------
-module(hello_test).
-author("IvoDukov").

%% EUnit test library
-include_lib("eunit/include/eunit.hrl").

simple_test() ->
  ?assert(true).

another_test() ->
  ?assertEqual(true, true).

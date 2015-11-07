%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. Oct 2015 11:44 PM
%%%-------------------------------------------------------------------
-module(ppool).
-author("IvoDukov").

%% API
-export([start_link/0, stop/0, start_pool/3,
  run/2, sync_queue/2, async_queue/2, stop_pool/1]).

start_link() ->
  ppool_supersup:start_link().

stop() ->
  ppool_supersup:stop().

start_pool(Name, Limit, {M,F,A}) ->
  ppool_supersup:start_pool(Name, Limit, {M,F,A}).

stop_pool(Name) ->
  ppool_supersup:stop_pool(Name).

run(Name, Args) ->
  ppool_serv:run(Name, Args).

async_queue(Name, Args) ->
  ppool_serv:async_queue(Name, Args).

sync_queue(Name, Args) ->
  ppool_serv:sync_queue(Name, Args).
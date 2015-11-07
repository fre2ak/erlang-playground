%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. Oct 2015 11:26 PM
%%%-------------------------------------------------------------------
-module(ppool_sup).
-author("IvoDukov").

-behaviour(supervisor).

%% API
-export([
  start_link/3,
  init/1
]).

start_link(Name, Limit, MFA) ->
  supervisor:start_link(?MODULE, {Name, Limit, MFA}).

init({Name, Limit, MFA}) ->
  MaxRestart = 1,
  MaxTime = 3600,
  {ok, {{one_for_all, MaxRestart, MaxTime},
    [{serv,
      {ppool_serv, start_link, [Name, Limit, self(), MFA]},
      permanent,
      5000, % Shutdown time
      worker,
      [ppool_serv]}]}}.
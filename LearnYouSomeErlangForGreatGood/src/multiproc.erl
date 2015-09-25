%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. Sep 2015 1:21 AM
%%%-------------------------------------------------------------------
-module(multiproc).
-author("IvoDukov").

%% API
-compile(export_all).

sleep(T) ->
  receive
  after T -> ok
  end.

flush() ->
  receive
    _ -> flush()
  after 0 ->
    ok
  end.

important() ->
  receive
    {Priority, Message} when Priority > 10 ->
      [Message | important()]
  after 0 ->
    normal()
  end.

normal() ->
  receive
    {_, Message} ->
      [Message | normal()]
  after 0 ->
    []
  end.
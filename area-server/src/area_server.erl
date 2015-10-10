%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. Oct 2015 2:24 PM
%%%-------------------------------------------------------------------
-module(area_server).
-author("IvoDukov").

%% API
-export([
  start/0,
  area/2
]).

start() ->
  spawn(fun loop/0).

area(Pid, What) ->
  rpc(Pid, What).

rpc(Pid, Request) ->
  Pid ! {self(), Request},
  receive
    {Pid, Response} ->
      Response
  end.

loop() ->
  receive
    {From, {square, Width}} ->
      From ! {self(), Width * Width},
      loop();
    {From, {rectangle, Width, Height}} ->
      From ! {self(), Width * Height},
      loop();
    {From, {triangle, Base, Height}} ->
      From ! {self(), Base * Height / 2},
      loop();
    {From, {circle, Radius}} ->
      From ! {self(), 3.14159 * Radius * Radius},
      loop();
    {From, Other} ->
      From ! {self(), {error, Other}},
      loop()
  end.
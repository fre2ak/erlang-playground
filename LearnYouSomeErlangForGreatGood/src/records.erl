%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. Sep 2015 10:47 PM
%%%-------------------------------------------------------------------
-module(records).
-author("IvoDukov").

%% API
-compile(export_all).

-record(robot, {
  name,
  type = industrial,
  hobbies,
  details = []
}).

first_robot() ->
  #robot {
    name = "Machatron",
    type = handmade,
    details = ["Moved by a small man inside"]
  }.

car_factory(CorpName) ->
  #robot {
    name = CorpName,
    hobbies = "Building cars"
  }.

repairman(Rob) ->
  Details = Rob#robot.details,
  NewRob = Rob#robot {
    details = ["Repaired by repairman" | Details]
  },
  {repaired, NewRob}.


-record(user, {id, name, group, age}).

admin_panel(#user{name = Name, group = admin}) ->
  Name ++ " is allowed!";
admin_panel(#user{name = Name}) ->
  Name ++ " is not allowed!".

adult_section(U = #user{}) when U#user.age >= 18 ->
  allowed;
adult_section(_) ->
  forbidden.


-include("records.hrl").

included() -> #included{ some_field = "What?" }.
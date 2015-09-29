%%%-------------------------------------------------------------------
%%% @author IvoDukov
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Sep 2015 10:39 PM
%%%-------------------------------------------------------------------
-author("IvoDukov").

-record(state, {
  name = "",
  other,
  ownitems = [],
  otheritems = [],
  monitor,
  from
}).
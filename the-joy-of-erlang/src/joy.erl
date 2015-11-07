-module(joy).
-author("Ivo Dukov").

-compile(export_all).

%% Logical functions

% not(true)  -> false;
% not(false) -> true.

% equals(A, A) -> true;
% equals(A, B) -> false.

% and(A, A) -> true;
% and(_, _) -> false.

% or(false, false) -> false;
% or(_, _) -> true.

% xor(A, A) -> false;
% xor(_, _) -> true.

% nand(true, true) -> false;
% nand(_, _) -> true.

% nor(false, false) -> true;
% nor(_, _) -> false.


%% Arithmetic

incr(A) -> A + 1.

decr(A) -> A - 1.

add(A, 0) ->
  A;
add(A, B) when B < 0 ->
  add(decr(A), incr(B));
add(A, B) ->
  add(incr(A), decr(B)).

sub(A, 0) ->
  A;
sub(A, B) when B < 0 ->
  sub(incr(A), incr(B));
sub(A, B) ->
  sub(decr(A), decr(B)).

multiply(_A, 0) ->
  0;
multiply(A, B) when B < 0 ->
  sub(multiply(A, incr(B)), A);
multiply(A, B) ->
  add(A, multiply(A, decr(B))).

reminder(A, B) when A < B ->
  A;
reminder(A, B) ->
  reminder(sub(A, B), B).

quotient(A, B) ->
  quotient(A, B, 0).

quotient(A, B, Answer) when A < B ->
  Answer;
quotient(A, B, Answer) ->
  quotient(sub(A, B), B, incr(Answer)).

pow(_A, 0) ->
  1;
pow(A, B) ->
  multiply(A, pow(A, decr(B))).


%% String Processing

capfirst([Head | Tail]) when Head >= $a, Head =< $z ->
  [Head + ($A - $a) | Tail];
capfirst(Other) ->
  Other.

uppercase(String) ->
  uppercase(String, []).

uppercase([], Output) ->
  lists:reverse(Output);
uppercase([Char | Rest], Output) when Char >= $a, Char =< $z ->
  uppercase(Rest, [Char + ($A - $a) | Output]);
uppercase([Char | Rest], Output) ->
  uppercase(Rest, [Char | Output]).

titlecase(String) ->
  titlecase(String, []).

titlecase([], Output) ->
  lists:reverse(Output);
titlecase([Char | Rest], [] = Output) when Char >= $a, Char =< $z ->
  titlecase(Rest, [Char + ($A - $a) | Output]);
titlecase([Char | Rest], [$\  | _] = Output) when Char >= $a, Char =< $z ->
  titlecase(Rest, [Char + ($A - $a) | Output]);
titlecase([Char | Rest], Output) ->
  titlecase(Rest, [Char | Output]).


%% Fun with Algorithms

atoi([$- | String]) ->
    -1 * atoi(String, 0);
atoi(String) ->
    atoi(String, 0).

atoi([], Acc) ->
    Acc;
atoi([C | Rest], Acc) when C >= $0, C =< $9 ->
    atoi(Rest, 10 * Acc + (C - $0)).


to_string(0) ->
    [$0];
to_string(Integer) when Integer < 0 ->
    [$- | to_string(-1 * Integer, [])];
to_string(Integer) ->
    to_string(Integer, []).

to_string(0, Acc) ->
    Acc;
to_string(Integer, Acc) ->
    to_string(Integer div 10, [(Integer rem 10) + $0 | Acc]).


num2excel(Number) ->
  num2excel((Number - 1) div 26, (Number - 1) rem 26, []).

num2excel(0, Remainder, Acc) ->
  [(Remainder + $A) | Acc];
num2excel(Quotient, Remainder, Acc) ->
  num2excel((Quotient - 1) div 26, (Quotient - 1) rem 26, [(Remainder + $A) | Acc]).


wordcount(Input) ->
  wordcount(Input, 0).

wordcount([], Count) ->
  Count;
wordcount([C1], Count) when C1 =/= $\  ->
  Count + 1;
wordcount([C1, C2 | Rest], Count) when C1 =/= $\ , C2 =:= $\  ->
  wordcount([C2 | Rest], Count + 1);
wordcount([_ | Rest], Count) ->
  wordcount(Rest, Count).


escape(String) ->
  escape(String, []).

escape([], Acc) ->
  lists:reverse(Acc);
escape([$< | Rest], Acc) ->
  escape(Rest, lists:reverse("&lt;", Acc));
escape([$> | Rest], Acc) ->
  escape(Rest, lists:reverse("&gt;", Acc));
escape([$& | Rest], Acc) ->
  escape(Rest, lists:reverse("&amp;", Acc));
escape([C | Rest], Acc) ->
  escape(Rest, [C | Acc]).


wordwrap(Input) ->
  wordwrap(Input, [], [], 0, 80).

wordwrap([], Acc, WordAcc, _LineLength, _WrapAt) ->
  lists:reverse(WordAcc ++ Acc);

% premature newline
wordwrap([$\n | Rest], Acc, WordAcc, _LineLength, WrapAt) ->
  wordwrap(Rest, [$\n | WordAcc ++ Acc], [], 0, WrapAt);

% hit the wrap length at a space character. add a newline
wordwrap([$\  | Rest], Acc, WordAcc, WrapAt, WrapAt) ->
  wordwrap(Rest, [$\n | WordAcc ++ Acc], [], 0, WrapAt);

% hit a space character before the wrap length. keep going
wordwrap([$\  | Rest], Acc, WordAcc, LineLength, WrapAt) ->
  wordwrap(Rest, [$\  | WordAcc ++ Acc], [], LineLength + 1 + length(WordAcc), WrapAt);

% overflowed the current line while building a word
wordwrap([C | Rest], Acc, WordAcc, 0, WrapAt)
  when erlang:length(WordAcc) > WrapAt ->
    wordwrap(Rest, Acc, [C | WordAcc], 0, WrapAt);
wordwrap([C | Rest], Acc, WordAcc, LineLength, WrapAt)
  when erlang:length(WordAcc) + LineLength > WrapAt ->
    wordwrap(Rest, [$\n | Acc], [C | WordAcc], 0, WrapAt);

wordwrap([C | Rest], Acc, WordAcc, LineLength, WrapAt) ->
  wordwrap(Rest, Acc, [C | WordAcc], LineLength, WrapAt).

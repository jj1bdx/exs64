%% (MIT License)
%%
%% Copyright (c) 2014 Kenji Rikitake. All rights reserved.
%%
%% Permission is hereby granted, free of charge, to any person obtaining a copy of
%% this software and associated documentation files (the "Software"), to deal in
%% the Software without restriction, including without limitation the rights to
%% use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
%% of the Software, and to permit persons to whom the Software is furnished to do
%% so, subject to the following conditions:
%%
%% The above copyright notice and this permission notice shall be included in all
%% copies or substantial portions of the Software.
%%
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%% SOFTWARE.

-module(exs64_speed).

-export([test_speed/0]).

%% From random module
-type ran() :: {integer(), integer(), integer()}.

-spec test_speed_exs64_uniform_rec1([float()], non_neg_integer(), non_neg_integer(),
    pos_integer(), exs64:state()) -> 'ok'.

test_speed_exs64_uniform_rec1(Acc, 0, _, _, _) ->
    _ = lists:reverse(Acc),
    ok;
test_speed_exs64_uniform_rec1(Acc, X, 0, R, I) ->
    _ = lists:reverse(Acc),
    test_speed_exs64_uniform_rec1([], X - 1, R, R, I);
test_speed_exs64_uniform_rec1(Acc, X, Q, R, I) ->
    {F, I2} = exs64:uniform_s(I),
    test_speed_exs64_uniform_rec1([F|Acc], X, Q - 1, R, I2).

-spec test_speed_exs64_uniform(non_neg_integer(), non_neg_integer()) -> non_neg_integer().

test_speed_exs64_uniform(P, Q) ->
    _ = statistics(runtime),
    I = exs64:seed(),
    ok = test_speed_exs64_uniform_rec1([], P, Q, Q, I),
    {_, T} = statistics(runtime),
    T.

-spec test_speed_orig_uniform_n_rec1([integer()], non_neg_integer(), non_neg_integer(), pos_integer(), ran()) -> 'ok'.

test_speed_orig_uniform_n_rec1(Acc, 0, _, _, _) ->
    _ = lists:reverse(Acc),
    ok;
test_speed_orig_uniform_n_rec1(Acc, X, 0, R, I) ->
    _ = lists:reverse(Acc),
    test_speed_orig_uniform_n_rec1([], X - 1, R, R, I);
test_speed_orig_uniform_n_rec1(Acc, X, Q, R, I) ->
    {F, I2} = random:uniform_s(10000, I),
    test_speed_orig_uniform_n_rec1([F|Acc], X, Q - 1, R, I2).

-spec test_speed_orig_uniform_n(non_neg_integer(), non_neg_integer()) -> non_neg_integer().

test_speed_orig_uniform_n(P, Q) ->
    _ = statistics(runtime),
    I = random:seed(),
    ok = test_speed_orig_uniform_n_rec1([], P, Q, Q, I),
    {_, T} = statistics(runtime),
    T.

-spec test_speed_exs64_uniform_n_rec1([non_neg_integer()], non_neg_integer(), non_neg_integer(), pos_integer(), exs64:state()) -> 'ok'.

test_speed_exs64_uniform_n_rec1(Acc, 0, _, _, _) ->
    _ = lists:reverse(Acc),
    ok;
test_speed_exs64_uniform_n_rec1(Acc, X, 0, R, I) ->
    _ = lists:reverse(Acc),
    test_speed_exs64_uniform_n_rec1([], X - 1, R, R, I);
test_speed_exs64_uniform_n_rec1(Acc, X, Q, R, I) ->
    {F, I2} = exs64:uniform_s(10000, I),
    test_speed_exs64_uniform_n_rec1([F|Acc], X, Q - 1, R, I2).

-spec test_speed_exs64_uniform_n(non_neg_integer(), non_neg_integer()) -> non_neg_integer().

test_speed_exs64_uniform_n(P, Q) ->
    _ = statistics(runtime),
    I = exs64:seed(),
    ok = test_speed_exs64_uniform_n_rec1([], P, Q, Q, I),
    {_, T} = statistics(runtime),
    T.

-spec test_speed_orig_uniform_rec1([float()], non_neg_integer(), non_neg_integer(), pos_integer(), ran()) -> 'ok'.

test_speed_orig_uniform_rec1(Acc, 0, _, _, _) ->
    _ = lists:reverse(Acc),
    ok;
test_speed_orig_uniform_rec1(Acc, X, 0, R, I) ->
    _ = lists:reverse(Acc),
    test_speed_orig_uniform_rec1([], X - 1, R, R, I);
test_speed_orig_uniform_rec1(Acc, X, Q, R, I) ->
    {F, I2} = random:uniform_s(I),
    test_speed_orig_uniform_rec1([F|Acc], X, Q - 1, R, I2).

-spec test_speed_orig_uniform(non_neg_integer(), non_neg_integer()) -> non_neg_integer().

test_speed_orig_uniform(P, Q) ->
    _ = statistics(runtime),
    I = random:seed(),
    ok = test_speed_orig_uniform_rec1([], P, Q, Q, I),
    {_, T} = statistics(runtime),
    T.

-spec test_speed() -> 'ok'.

test_speed() ->
    io:format("{orig_uniform, orig_uniform_n, exs64_uniform, exs64_uniform_n}~n~p~n",
              [{test_speed_orig_uniform(100, 10000),
                test_speed_orig_uniform_n(100, 10000),
                test_speed_exs64_uniform(100, 10000),
                test_speed_exs64_uniform_n(100, 10000)}
              ]).

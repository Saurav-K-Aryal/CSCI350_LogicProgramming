% Logic Programming Project
% Structures of Programming Languages | Spring 2017
%
% This file contains solutions to the aforementioned project
% assignments.
%
% @author Saurav Keshari Aryal, @02773159, Howard University.


% sum-up-numbers-simple(L, N) returns true if N is the sum of the
% numbers not in nested lists in the given list L.


% If L = [], N = 0
sum-up-numbers-simple([], 0).

% If HEAD is a number, compute sum.
sum-up-numbers-simple([HEAD|TAIL], N):-
    number(HEAD),
    sum-up-numbers-simple(TAIL, SubSum),
    N is HEAD + SubSum.

% If HEAD is a non-number, skip element.
sum-up-numbers-simple([HEAD|TAIL], N):-
    \+ number(HEAD),
    sum-up-numbers-simple(TAIL, SubSum),
    N is SubSum.


% sum-up-numbers-general(L, N) returns true if N is the sum of the
% numbers, inlcuding ones in nested lists, in the given list L.


% If L = [], N = 0
sum-up-numbers-general([], 0).

% If HEAD is a number, add to sum.
sum-up-numbers-general([HEAD|TAIL], N):-
    number(HEAD),
    sum-up-numbers-simple(TAIL, SubSum),
    N is HEAD + SubSum.

% If HEAD is a list, sum numbers in head and add some of tail
sum-up-numbers-simple([HEAD|TAIL], N):-
    is_list(HEAD),
    sum-up-numbers-simple(TAIL, TailSum),
    sum-up-numbers-general(HEAD, HeadSum),
    N is HeadSum + TailSum.

% If HEAD cannot prove to be both number and list, continue.
sum-up-numbers-general([HEAD|TAIL], N):-
	\+ number(HEAD),
	\+ is_list(HEAD),
	sum-up-numbers-general(TAIL, SubSum),
	N is SubSum. 
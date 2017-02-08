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
    sum-up-numbers-simple(TAIL, TailSum),
    N is HEAD + TailSum.

% If HEAD is a non-number, skip element.
sum-up-numbers-simple([HEAD|TAIL], N):-
    \+ number(HEAD),
    sum-up-numbers-simple(TAIL, TailSum),
    N is TailSum.


% sum-up-numbers-general(L, N) returns true if N is the sum of the
% numbers, inlcuding ones in nested lists, in the given list L.


% If L = [], N = 0
sum-up-numbers-general([], 0).

% If HEAD is a number, add to sum.
sum-up-numbers-general([HEAD|TAIL], N):-
    number(HEAD),
    sum-up-numbers-general(TAIL, TailSum),
    N is HEAD + TailSum.

% If HEAD is a list, sum numbers in head and add some of tail
sum-up-numbers-general([HEAD|TAIL], N):-
    is_list(HEAD),
    sum-up-numbers-general(TAIL, TailSum),
    sum-up-numbers-general(HEAD, HeadSum),
    N is HeadSum + TailSum.

% If HEAD cannot be proven to be both number and list, continue.
sum-up-numbers-general([HEAD|TAIL], N):-
	\+ number(HEAD),
	\+ is_list(HEAD),
	sum-up-numbers-general(TAIL, TailSum),
	N is TailSum.


% find-list-min(L, MIN_VAL) returns the minimum numeric value in the given list L.

% If single numeric element in list, return element.
find-list-min([HEAD], HEAD).

%% If single non-numeric element in list, return false.
find-list-min([HEAD], MIN_VAL):-
	\+ number(HEAD).

% If multiple elements, compare first two if both are number
find-min([HEAD,NECK|TAIL], MIN_VAL):-
	number(HEAD),
	number(NECK),
	HEAD > NECK,           
	find-min([NECK|TAIL], MIN_VAL);

find-min([HEAD,NECK|TAIL], MIN_VAL):-
	number(HEAD),
	number(NECK),
	HEAD =< NECK,         
	find-min([HEAD|TAIL], MIN_VAL).

find-min([HEAD,NECK|TAIL], MIN_VAL):-    % if second element is a number but not the first one
	\+(number(HEAD)),
	number(NECK),
	find-min([NECK|TAIL], MIN_VAL).

find-min([HEAD,NECK|TAIL], MIN_VAL):-   %  if first element is a number but not the second one
	number(HEAD),
	\+(number(NECK)),
	find-min([HEAD|TAIL], MIN_VAL).

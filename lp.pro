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
find-list-min([HEAD], MIN_VAL):-
    number(HEAD),
    MIN_VAL is HEAD.

%return false if last element in non-numeric
find-list-min([HEAD]):-
    \+number(HEAD).


% If multiple elements, compare first two if both are number
find-list-min([HEAD,NECK|TAIL], MIN_VAL):-
	number(HEAD),
	number(NECK),
	HEAD > NECK,           
	find-list-min([NECK|TAIL], MIN_VAL).

find-list-min([HEAD,NECK|TAIL], MIN_VAL):-
	number(HEAD),
	number(NECK),
	HEAD =< NECK,         
	find-list-min([HEAD|TAIL], MIN_VAL).

%if HEAD is non-numeric
find-list-min([HEAD,NECK|TAIL], MIN_VAL):-
	\+ number(HEAD),
	number(NECK),
	find-list-min([NECK|TAIL], MIN_VAL).

% if NECK is non-numeric
find-list-min([HEAD,NECK|TAIL], MIN_VAL):-  
	number(HEAD),
	\+(number(NECK)),
	find-list-min([HEAD|TAIL], MIN_VAL).

% if both are non-numeric.
find-list-min([HEAD, NECK|TAIL], MIN_VAL):-
    \+ number(HEAD),
	\+(number(NECK)),
	find-list-min(TAIL, MIN_VAL).


% get-greater(L, X) returns all numbers greater than X in L.

% Base case
get-greater([], _, []) :- !.

% if HEAD is number, HEAD > min-value
get-greater([HEAD|TAIL], X, L) :-
	number(HEAD),
	HEAD > X,
	get-greater(TAIL, X, L1),
	append([HEAD], L1, L).

% if HEAD is number, but HEAD <= min-value
get-greater([HEAD|TAIL], X, L) :-
	number(HEAD),
	HEAD =< X,
	get-greater(TAIL, X, L).

% if HEAD is non-number, ignore.
get-greater([HEAD|TAIL], X, L) :-
	\+ number(HEAD),
	get-greater(TAIL, X, L).


% min-above-min(L1, L2, N) return true if N is the minimum of the numbers in L1 
% that are larger than the smallest number in L2. If there is no number in L2,
% all the numbers in L1 should be used to calculate the minimum.

% if minimum of L2 exists, try..
min-above-min(L1, L2, N):-
	find-list-min(L2, MinL2),
	get-greater(L1, MinL2, GreaterList),
	find-list-min(GreaterList, N).

% if minimum of L2 does not exist, do..
min-above-min(L1, L2, N):-
    \+ find-list-min(L2, MinL2),
	find-list-min(L1, N).


% my-flatten(L1, L2) returns a list L2 by flattening L1

%if list is empty
my-flatten([], []).

% if HEAD is not a list.
my-flatten([HEAD|TAIL], L2):-
	\+ is_list(HEAD),
	my-flatten(TAIL, FlatTail),
	append([HEAD], FlatTail, L2).

% if HEAD is list.
my-flatten([HEAD|TAIL], L2):-
	is_list(HEAD),
	my-flatten(TAIL, FlatTail),
	my-flatten(HEAD, FlatHead),
	append(FlatHead, FlatTail, L2).


% my-intersection(L1, L2) returns a list which is intersection of
% two simple lists L1 and L2.

% empty list base case.
my-intersection([],_,[]).

% if common member in both lists.
my-intersection([HEAD|TAIL1],M,[HEAD|TAIL2]) :-
	member(HEAD,M),
	my-intersection(TAIL1,M,TAIL2).

% if not common member.
my-intersection([HEAD|TAIL],M,Z) :- 
	\+ member(HEAD,M),
	my-intersection(TAIL,M,Z).


% common-unique-elements(L1, L2, L) returns true if N is a simple list
% of the items that appear in both L1 and L2

% empty list base case.
common-unique-elements([], _, []).

% for non-empty case, flatten and return intersection of two lists.
common-unique-elements(L1, L2 , L):- 
	my-flatten(L1, FlatL1),
	my-flatten(L2, FlatL2),
	my-intersection(FlatL1, FlatL2, L).
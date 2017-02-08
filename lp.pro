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

% If HEAD is a number
sum-up-numbers-simple([HEAD|TAIL], N):-
   sum-up-numbers-simple(TAIL,  SubSum),
   number(HEAD),
   N is HEAD + SubSum.

% ///////////////////////////////////////////////////////////////////////////////////////////////////

% For Assignment 2 - The Water Jug Problem 7L Jug & 4L Jug. Get 5L of Water????


checkXY(F,S):- F>=0,F=<4,S>=0,S=<7.

% Pour from 4L jug to 7L jug until 7L is full

move74((X,Y), (NewX,7)) :-
	                      NewX is X + Y - 7, X + Y > 7, checkXY(NewX,7).

% Pour from 7L jug to 4L jug until the 7L is empty

move74((X,Y), (NewX,0)) :-
	                      NewX is X + Y, X + Y =< 4, checkXY(NewX,0).

% Pour from 7L jug to 4L jug until 4L is full -
move74((X,Y), (4,NewY)) :-
	                      NewY is Y + X - 4, X + Y > 4, checkXY(4,NewY).

% Pour from the 4L jug to the 7L jug until the 4L jug is empty - *Last*

move74((X,Y), (0,NewY)) :-
	                      NewY is X + Y, X + Y =< 7, checkXY(0,NewY).

% Fill the 4L jug from tap

move74((X,Y), (4,Y)):-
                          X=<4, X>=0.

% Fill the 7L jug from tap

move74((X,Y), (X,7)):-
	                   Y=<7, Y>=0.

% Empty the 7L jug down the sink

move74((X,Y), (X,0)) :-
			    Y >= 0.

% Empty the 4L jug down the sink

move74((X,Y), (0,Y)) :-
	                    X >= 0.

% For finding 5L, with no back tracking
% R is a list of everything after the goal and then X1 & X2
% solve([Before], Fill, [After]).

solve74([(X1,Y1)|R], [(X2,5), (X1,Y1)|R]):-
					        move74((X1,Y1), (X2,5)), !.

% ************-Reference this part of code is from a book-************
% Recursion...................................................
% Starting at Zero, Zero
% Start pouring the jugs for each state
% True if "f5(X1,Y1)" is not a member of "[f5(X0,Y0)|R]" List. --> Fail.
%                              --> library(lists) - List Manipulation
% Stop when found 5  --> Goal State

solve74([(X1,Y1)|R], Path) :-
                                move74((X1,Y1), (X2,Y2)),
			        not(member((X2,Y2), [(X1,Y1)|R])),
                                solve74([(X2,Y2), (X1,Y1)|R], Path).


% Start the search with two empty jugs...

solved74(PathList) :-
	             solve74([(0,0)], PathList).


% ? - solved74([]).
% ? - solved74(Path), print(Path), nl, write(Path).
% ? - solved74(Path), write(Path), nl, fail.
% ? - solved74(Path).


% ///////////////////////////////////////////////////////////////////////////////////////////////////




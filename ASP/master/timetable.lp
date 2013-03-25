% Define the days of the week.
day(mon).
day(tues).
day(wed).
day(thurs).
day(fri).

% Define the sessions in each day.
ses(wed, 1..4).
ses(X, 1..9) :- day(X), X != wed.

% Define when the morning and the afternoon is.
morning(1..4).
afternoon(5..9).

% Define the conditions where the type holds.
holds(C, a) :- allocated(C, session(D, T), R), allocated(C, session(D, T1), R), allocated(C, session(D, T2), R), T1 == T + 1, T2 == T + 2.
holds(C, b) :- allocated(C, session(D, T), R), allocated(C, session(D, T1), R), allocated(C, session(D, T2), _), T1 == T + 1, opposite_times(T, T2).
holds(C, c) :- allocated(C, session(D1, T), R), allocated(C, session(D1, T1), R), allocated(C, session(D2, T2), _), D1 != D2, T1 == T + 1.

% Define when two times are in the opposite 'sides' of the day.
opposite_times(T1, T2) :- morning(T1), afternoon(T2), T2 != T1 + 1.
opposite_times(T1, T2) :- morning(T2), afternoon(T1), T1 != T2 + 1.

% Only have enough allocations for each subject.
N { allocated(C, session(D, T), R) : ses(D, T) : room(R) : T != 4 : T != 5 } N :- per_week(C, N).

unclashable(C1, C2) :- unclashable(C2, C1).

% Ensure that the types hold.
:- holds(C,a), not course_type(C, a).
:- not holds(C, a), course_type(C, a).

:- holds(C,b), not course_type(C, b).
:- not holds(C, b), course_type(C, b).

:- holds(C,c), not course_type(C, c).
:- not holds(C, c), course_type(C, c).

% A course can't have two rooms concurrently (subject to change).
:- allocated(C, session(D, T), R1), allocated(C, session(D, T), R2), R1 != R2.
% Two courses can't be scheduled in the same room concurrently.
:- allocated(C1, session(D, T), R), allocated(C2, session(D, T), R), C1 != C2.
% Two courses which can't be clashed can't be scheduled concurrently.
:- allocated(C1, session(D, T), _), allocated(C2, session(D, T), _), unclashable(C1, C2).

% Only output allocated clauses.
#hide.
#show allocated/3.

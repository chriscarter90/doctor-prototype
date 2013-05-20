% Define the days of the week.
day(mon).
day(tues).
day(wed).
day(thurs).
day(fri).

% Define the sessions in each day.
ses(wed, 1..4, W, Y) :- term(Y), week_term(W, Y).
ses(X, 1..9, W, Y) :- day(X), X != wed, term(Y), week_term(W, Y).

% Define when the morning and the afternoon is.
morning(1..4).
afternoon(5..9).

% Define the conditions where the type holds.
holds(C, a, W, E) :- course_type(C, a), allocated(C, session(D, T, W, E), R),  allocated(C, session(D, T1, W, E), R),  allocated(C, session(D, T2, W, E), R),  T1 == T + 1, T2 == T + 2.
holds(C, b, W, E) :- course_type(C, b), allocated(C, session(D, T, W, E), R),  allocated(C, session(D, T1, W, E), R),  allocated(C, session(D, T2, W, E), _),  T1 == T + 1, opposite_times(T, T2).
holds(C, c, W, E) :- course_type(C, c), allocated(C, session(D1, T, W, E), R), allocated(C, session(D1, T1, W, E), R), allocated(C, session(D2, T2, W, E), _), T1 == T + 1, D1 != D2.

% Define when two times are in the opposite 'sides' of the day.
opposite_times(T1, T2) :- morning(T1), afternoon(T2), T2 != T1 + 1.
opposite_times(T1, T2) :- morning(T2), afternoon(T1), T1 != T2 + 1.

% Only have enough allocations for each subject, for each week that it's taught.
N { allocated(C, session(D, T, W, E), R) : ses(D, T, W, E) : room(R) : T != 4 : T != 5 } N :- per_week(C, N, W, E).

unclashable(C1, C2) :- unclashable(C2, C1).

% Ensure that the types hold (for weeks which have 3 lectures, otherwise who cares?).
:- not holds(C, T, W, E), course_type(C, T), per_week(C, 3, W, E).

% A course can't have two rooms concurrently (subject to change).
:- allocated(C, session(D, T, W, E), R1), allocated(C, session(D, T, W, E), R2), R1 != R2.
% Two courses can't be scheduled in the same room concurrently.
:- allocated(C1, session(D, T, W, E), R), allocated(C2, session(D, T, W, E), R), C1 != C2.
% Two courses which can't be clashed can't be scheduled concurrently.
:- allocated(C1, session(D, T, W, E), _), allocated(C2, session(D, T, W, E), _), unclashable(C1, C2).

alloc_gen(C, D, T) :- allocated(C, session(D, T, _, _), _).
alloc_gen_term(C, D, T, E) :- allocated(C, session(D, T, _, E), _).

#maximize { preference_time_met(_, _) }.
#maximize { preference_day_met(_, _) }.
#minimize { prefer_not_time_violated(_, _) }.
#minimize { prefer_not_day_violated(_, _) }.
#minimize { prefer_not_before_violated(_, _) }.
#minimize { prefer_not_after_violated(_, _) }.

:- strictly_not_before_violated(C, T).
:- strictly_not_after_violated(C, T).
:- strictly_not_before_time_day_violated(C, T, D).
:- strictly_not_after_time_day_violated(C, T, D).
:- precisely_violated(C, T, D).

:- allocated(X, session(D, T, W, E), _), allocated(Y, session(D, T, W, E), _), never_clash(X, Y).

time_clash(D, T, W, E, C1, C2) :- clash(C1, C2), allocated(C1, session(D, T, W, E), _), allocated(C2, session(D, T, W, E), _).

Min { alloc_gen_term(C, D, T, E) : ses(D, T, _, E) } Max :- min_per_week(C, E, Min), max_per_week(C, E, Max).

min_hours(C1, C2, W, E, H1) :- per_week(C1, H1, W, E), per_week(C2, H2, W, E), H1 <= H2.
min_hours(C1, C2, W, E, H2) :- per_week(C1, H1, W, E), per_week(C2, H2, W, E), H1 > H2.

% Only output allocated clauses.
#hide.
#show allocated/3.

% ============================================= %
%% Check that the course types hold

% Define the conditions where the type holds.
holds(C, a, W, E) :- course_type(C, a), allocated(C, session(D, T, W, E), R),  allocated(C, session(D, T + 1, W, E), R),  allocated(C, session(D, T + 2, W, E), R).

holds(C, b, W, E) :- course_type(C, b), consecutive(C, D, W, E, afternoon),  allocated(C, session(D, T2, W, E), _), morning(T2).
holds(C, b, W, E) :- course_type(C, b), consecutive(C, D, W, E, morning),  allocated(C, session(D, T2, W, E), _), afternoon(T2).

holds(C, c, W, E) :- course_type(C, c), consecutive(C, D1, W, E), allocated(C, session(D2, _, W, E), _), D1 != D2.

consecutive(C, D, W, E) :- course_type(C, c), allocated(C, session(D, T, W, E), R), allocated(C, session(D, T + 1, W, E), R).
consecutive(C, D, W, E, morning) :- course_type(C, b), allocated(C, session(D, T, W, E), R), allocated(C, session(D, T + 1, W, E), R), morning(T).
consecutive(C, D, W, E, afternoon) :- course_type(C, b), allocated(C, session(D, T, W, E), R), allocated(C, session(D, T + 1, W, E), R), afternoon(T).

% Ensure that the types hold (for weeks which have 3 lectures, otherwise who cares?).
:- not holds(C, T, W, E), course_type(C, T), per_week(C, 3, W, E).
:- not holds(C, T, W, E), W = 2..10, course_type(C, T), per_week_2_10(C, 3, E).
:- not holds(C, T, W, E), W = 2..9, course_type(C, T), per_week_2_9(C, 3, E).

% ============================================= %
% Only have enough allocations for each subject, for each week that it's taught.

N { allocated(C, session(D, T, W, E), R) : ses(D, T, W, E) : room(R) : T != 4 : T != 5 } N :- per_week(C, N, W, E).

%% Weeks 2-10 same:
N { allocated(C, session(D, T, 2, E), R) : ses(D, T, 2, E) : room (R) : T != 4 : T != 5 } N :- per_week_2_10(C, N, E).

allocated(C, session(D, T, 3..10, E), R) :- allocated(C, session(D, T, 2, E), R), per_week_2_10(C, _, E).
%%

%% Weeks 2-9 same:
N { allocated(C, session(D, T, 2, E), R) : ses(D, T, 2, E) : room(R) : T != 4 : T != 5 } N :- per_week_2_9(C, N, E).

allocated(C, session(D, T, 3..9, E), R) :- allocated(C, session(D, T, 2, E), R), per_week_2_9(C, _, E).
%%

% ============================================= %

% Two courses which ARE allowed to be clashed can't be scheduled in the same room concurrently.
:- allocated(C1, S, R), allocated(C2, S, R), C1 > C2, not never_clash(C1, C2).

% The same course can't be in the two rooms at the same time.
:- allocated(C, S, R1), allocated(C, S, R2), R1 > R2.

% Two courses which are not allowed to be clashed cannot be put at the same time.
:- allocated(C1, S, R1), allocated(C2, S, R2), never_clash(C1, C2), R1 >= R2.

% ============================================= %

% Two courses which can't be clashed can't be scheduled concurrently.
unclashable(C1, C2) :- unclashable(C2, C1).
:- allocated(C1, S, R1), allocated(C2, S, R2), unclashable(C1, C2), R1 >= R2.

% Only have between Min and Max different slot times over the term.
Min { alloc_gen_term(C, D, T, E, R) : room(R) : day_time(D, T) : term(E) } Max :- min_per_week(C, E, Min), max_per_week(C, E, Max).

% Generalise allocated clauses for use elsewhere.
alloc_gen(C, D, T) :- allocated(C, session(D, T, _, _), _).
alloc_gen_term(C, D, T, E, R) :- allocated(C, session(D, T, _, E), R).

% Putting clashed courses together.
1 { allocated(C1, S, R) : room(R) } 1 :- allocated(C2, S, _), clash_together(C1, C2), week_term_hours(C1, H1, W, E), week_term_hours(C2, H2, W, E), H1 < H2.
1 { allocated(C1, S, R) : room(R) } 1 :- allocated(C2, S, _), clash_together(C1, C2), week_term_hours(C1, H1, W, E), week_term_hours(C2, H2, W, E), H1 == H2.

% ============================================= %
%% Preferences

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

% ============================================= %

% Only output allocated clauses.
#hide.
#show allocated/3.

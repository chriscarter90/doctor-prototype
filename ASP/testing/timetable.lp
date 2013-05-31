% ============================================= %
%% Session definitions

% Define the days of the week.
day(1..5).

day_time(X, 1..9) :- day(X), X != 3.
day_time(3, 1..4).

% Define the sessions in each day.
ses(D, T, W, E) :- day_time(D, T), week_term(W, E).

% Define when the morning and the afternoon is.
morning(1..4).
afternoon(5..9).

% ============================================= %
%% Check that the course types hold

% ### Put course type definitions in course_types.lp ### %
% Define the type of each course:
% a - Schedule all three lectures consecutively
% b - Schedule lectures in 2:1 on the same day
% c - Schedule lectures in 2:1 on different days

course(X) :- b1(X).
course(X) :- b2(X).
course(X) :- b3(X).
course(X) :- b4(X).

room(X) :- lecture_room(X).
room(X) :- lab_room(X).

session_type(lecture).
session_type(tutorial).
session_type(lab).

% Define the conditions where the type holds.
holds(C, a, W, E) :- course_type(C, a), allocated(C, session(D, T, W, E), R, _),  allocated(C, session(D, T + 1, W, E), R, _),  allocated(C, session(D, T + 2, W, E), R, _).

holds(C, b, W, E) :- course_type(C, b), consecutive(C, D, W, E, afternoon),  allocated(C, session(D, T2, W, E), _, _), morning(T2).
holds(C, b, W, E) :- course_type(C, b), consecutive(C, D, W, E, morning),  allocated(C, session(D, T2, W, E), _, _), afternoon(T2).

holds(C, c, W, E) :- course_type(C, c), consecutive(C, D1, W, E), allocated(C, session(D2, _, W, E), _, _), D1 != D2.

consecutive(C, D, W, E) :- course_type(C, c), allocated(C, session(D, T, W, E), R, _), allocated(C, session(D, T + 1, W, E), R, _).
consecutive(C, D, W, E, morning) :- course_type(C, b), allocated(C, session(D, T, W, E), R, _), allocated(C, session(D, T + 1, W, E), R, _), morning(T).
consecutive(C, D, W, E, afternoon) :- course_type(C, b), allocated(C, session(D, T, W, E), R, _), allocated(C, session(D, T + 1, W, E), R, _), afternoon(T).

% Ensure that the types hold (for weeks which have 3 lectures, otherwise who cares?).
:- not holds(C, T, W, E), course_type(C, T), total_per_week(C, 3, W, E).

% ============================================= %
% Only have enough allocations for each subject, for each week that it's taught.

N { allocated(C, session(D, T, W, E), R, Type) : ses(D, T, W, E) : room(R) : T != 4 : T != 5 } N :- per_week(C, N, W, E, Type).

%% Weeks 2-10 same:
N { allocated(C, session(D, T, 2, E), R, Type) : ses(D, T, 2, E) : room (R) : T != 4 : T != 5 } N :- per_week_2_10(C, N, E, Type).

allocated(C, session(D, T, 3..10, E), R, Type) :- allocated(C, session(D, T, 2, E), R, Type), per_week_2_10(C, _, E, Type).
%%

%% Weeks 2-9 same:
N { allocated(C, session(D, T, 2, E), R, Type) : ses(D, T, 2, E) : room(R) : T != 4 : T != 5 } N :- per_week_2_9(C, N, E, Type).

allocated(C, session(D, T, 3..9, E), R, Type) :- allocated(C, session(D, T, 2, E), R, Type), per_week_2_9(C, _, E, Type).
%%

:- allocated(C1, S, R, lecture), not lecture_room(R).
:- allocated(C1, S, R, tutorial), not lecture_room(R).
:- allocated(C1, S, R, lab), not lab_room(R).

% ============================================= %
% Basic constraints

% Two courses which ARE allowed to be clashed can't be scheduled in the same room concurrently.
:- alloc_no_type(C1, S, R), alloc_no_type(C2, S, R), C1 > C2, not never_clash(C1, C2).

% The same course can't be in the two rooms at the same time.
:- alloc_no_type(C, S, R1), alloc_no_type(C, S, R2), R1 > R2.

% The same course can't have two types on at once.
:- alloc_no_room(C, S, Type), alloc_no_room(C, S, Type2), Type != Type2.

% Two courses which are not allowed to be clashed cannot be put at the same time.
:- alloc_no_type(C1, S, R1), alloc_no_type(C2, S, R2), never_clash(C1, C2), R1 >= R2.

% A lecturer can't be in two places at once.
:- alloc_no_type(C1, S, R1), alloc_no_type(C2, S, R2), not never_clash(C1, C2), C1 > C2, teaches(C1, L), teaches(C2, L).

% Only have between Min and Max different slot times over the term.
Min { alloc_gen_term(C, D, T, E, R, Type) : room(R) : day_time(D, T) : term(E) } Max :- min_per_week(C, E, Min, Type), max_per_week(C, E, Max, Type).

% ============================================= %
% Generalise allocated clauses for use elsewhere.

alloc_gen(C, D, T) :- allocated(C, session(D, T, _, _), _, _).
alloc_gen_type(C, D, T, Type) :- allocated(C, session(D, T, _, _), _, Type).
alloc_gen_term(C, D, T, E, R, Type) :- allocated(C, session(D, T, _, E), R, Type).
alloc_no_type(C, S, R) :- allocated(C, S, R, _).
alloc_no_room(C, S, Type) :- allocated(C, S, _, Type).
alloc_no_room_or_type(C, S) :- allocated(C, S, _, _).

% ============================================= %
% Unclashables

% ### Put unclashables in unclashables.lp ### %

% Two courses which can't be clashed can't be scheduled concurrently.
unclashable(C1, C2) :- unclashable(C2, C1).
:- alloc_no_type(C1, S, R1), alloc_no_type(C2, S, R2), unclashable(C1, C2), R1 >= R2.

never_clash(X, Y) :- b1(X), b1(Y), X != Y, not clash_exception(X, Y).
never_clash(X, Y) :- b2(X), b2(Y), X != Y, not clash_exception(X, Y).
never_clash(X, Y) :- b3(X), b3(Y), X != Y, not clash_exception(X, Y).
never_clash(X, Y) :- b4(X), b4(Y), X != Y, not clash_exception(X, Y).

% ============================================= %
% Putting clashed courses together.

% ### Put clash wanted clauses into clashes.lp ### %

1 { allocated(C1, S, R, Type) : room(R) : session_type(Type) } 1 :- alloc_no_room_or_type(C2, S), clash_together(C1, C2), total_per_week(C1, H1, W, E), total_per_week(C2, H2, W, E), H1 < H2.
1 { allocated(C1, S, R, Type) : room(R) : session_type(Type) } 1 :- alloc_no_room_or_type(C2, S), clash_together(C1, C2), total_per_week(C1, H1, W, E), total_per_week(C2, H2, W, E), H1 == H2.

%% Clash exceptions are ALLOWED to clash, doesn't mean that they SHOULD.
clash_exception(X, Y) :- clash_exception(Y, X).

%% TEMPORARY to allow the timetable to not be over constrained
% clash_exception(X, Y) :- b3(X), b3(Y), X != Y.
% clash_exception(X, Y) :- b4(X), b4(Y), X != Y.

%% Only clash if they're compabible and we want to.
clash_together(X, Y) :- clash_compatible(X, Y), clash_wanted(X, Y).

%% Check for clash compatibility.
clash_compatible(X, Y) :- course(X), course(Y), not types_clash(X, Y), not matching_lecturer(X, Y).

%% Check for a common lecturer.
matching_lecturer(X, Y) :- teaches(X, L), teaches(Y, L).

%% Types clash
types_clash(X, Y) :- course_type(X, T1), course_type(Y, T2), T1 != T2.

% ============================================= %
%% Course week rules

% ### Put course week data into into course_weeks.lp ### %

min_per_week(C, t, M, Type) :- course(C), week_term_hours(C, _, _, t, Type), M = #min[ week_term_hours(C, H, W, t, Type) = H ].
max_per_week(C, t, M, Type) :- course(C), week_term_hours(C, _, _, t, Type), M = #max[ week_term_hours(C, H, W, t, Type) = H ].

%% For when weeks 2-10 are the same:
per_week_2_10(C, H, t, Type) :- week_term_hours(C, H, W, t, Type) : W = 3..10, week_term_hours(C, H, 2, t, Type).
per_week(C, H, W, t, Type) :- week_term_hours(C, H, W, t, Type), W < 2, per_week_2_10(C, _, t, Type).
per_week(C, H, W, t, Type) :- week_term_hours(C, H, W, t, Type), W > 10, per_week_2_10(C, _, t, Type).

%% For when 2-9 are the same and 10 is different:
per_week_2_9(C, H, t, Type) :- week_term_hours(C, H, W, t, Type) : W = 3..9, week_term_hours(C, H, 2, t, Type), not per_week_2_10(C, H, t, Type).
per_week(C, H, W, t, Type) :- week_term_hours(C, H, W, t, Type), W < 2, per_week_2_9(C, _, t, Type).
per_week(C, H, W, t, Type) :- week_term_hours(C, H, W, t, Type), W > 9, per_week_2_9(C, _, t, Type).

%% For when neither of the above hold:
per_week(C, H, W, t, Type) :- week_term_hours(C, H, W, t, Type), not per_week_2_10(C, H, t, Type), not per_week_2_9(C, H, t, Type).

total_per_week(C, M, W, t) :- course(C), week_term_hours(C, _, W, t, _), M = [ week_term_hours(C, H, W, t, _, _) = H ].

week_term_hours(C, M, W, t, Type) :- course(C), week_term_hours(C, _, W, t, _, Type), M = [ week_term_hours(C, H, W, t, _, Type) = H ].

% ============================================= %
%% Preferences

% ### Put preference clauses into preferences.lp ### %

strictly_not_before_violated(C, T) :- strictly_not_before(C, T), alloc_no_room_or_type(C, session(_, T1, _, _)), T1 < T.
strictly_not_after_violated(C, T) :- strictly_not_after(C, T), alloc_no_room_or_type(C, session(_, T1, _, _)), T1 > T.

strictly_not_before_time_day_violated(C, T, D) :- strictly_not_before_time_day(C, T, D), alloc_no_room_or_type(C, session(D, T1, _, _)), T1 < T.
strictly_not_after_time_day_violated(C, T, D) :- strictly_not_after_time_day(C, T, D), alloc_no_room_or_type(C, session(D, T1, _, _)), T1 > T.

preference_time_met(C, T) :- alloc_no_room_or_type(C, session(_, T, _, _)), prefer_time(C, T).
preference_day_met(C, D) :- alloc_no_room_or_type(C, session(D, _, _, _)), prefer_day(C, D).

prefer_not_time_violated(C, T) :- alloc_no_room_or_type(C, session(_, T, _, _)), prefer_not_time(C, T).
prefer_not_day_violated(C, D) :- alloc_no_room_or_type(C, session(D, _, _, _)), prefer_not_day(C, D).

prefer_not_before_violated(C, T) :- alloc_no_room_or_type(C, session(_, T1, _, _)), prefer_not_before(C, T), T1 < T.
prefer_not_after_violated(C, T) :- alloc_no_room_or_type(C, session(_, T1, _, _)), prefer_not_after(C, T), T1 > T.

precisely_violated(C, D, T) :- precisely(C, D, T), not alloc_gen(C, D, T).
precisely_violated(C, D, T, Type) :- precisely(C, D, T, Type), not alloc_gen_type(C, D, T, Type).

#minimize { precisely_violated(_, _, _, _) }.
#minimize { precisely_violated(_, _, _) }.
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

% ============================================= %

% Only output allocated clauses.
#hide.
#show allocated/4.

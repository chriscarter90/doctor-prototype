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

% Define the courses to be timetabled.
course("101").
course("102").
course("103").
course("104").
course("105").
course("106").
course("107").
course("108").
course("109").
course("110").
% course("111").
% course("112").
% course("113").
% course("114").
% course("115").
% course("116").
% course("117").
% course("118").
% course("119").
% course("120").

% Define the rooms to be timetabled.
room("308").
room("311").
room("144").
room("145").

% Define the lecturers.
lecturer("abc1").
lecturer("bcd2").
lecturer("cde3").
lecturer("def4").

% Define the type of each course:
% a - Schedule all three lectures consecutively
% b - Schedule lectures in 2:1 on the same day
% c - Schedule lectures in 2:1 on different days
course_type("101", a).
course_type("102", b).
course_type("103", c).
course_type("104", b).
course_type("105", a).
course_type("106", c).
course_type("107", a).
course_type("108", c).
course_type("109", b).
course_type("110", a).

% Define who teaches what course.
teaches("101", "abc1").
teaches("102", "bcd2").
teaches("103", "cde3").
teaches("104", "bcd2").
teaches("105", "cde3").
teaches("106", "def4").
teaches("107", "def4").

% Define which courses CANNOT be scheduled concurrently,
% Ensuring a reflexive relationship.
unclashable(C1, C2) :- unclashable(C2, C1).
unclashable("105","101").
unclashable("104","105").

% State that all courses are scheduled at 3 hours per week.
per_week(C, 3) :- course(C).

% Define the conditions where the type holds.
holds(C, a) :- allocated(C, session(D, T), R), allocated(C, session(D, T1), R), allocated(C, session(D, T2), R), T1 == T + 1, T2 == T + 2.
holds(C, b) :- allocated(C, session(D, T), R), allocated(C, session(D, T1), R), allocated(C, session(D, T2), _), T1 == T + 1, opposite_times(T, T2).
holds(C, c) :- allocated(C, session(D1, T), R), allocated(C, session(D1, T1), R), allocated(C, session(D2, T2), _), D1 != D2, T1 == T + 1.

% Define when two times are in the opposite 'sides' of the day.
opposite_times(T1, T2) :- morning(T1), afternoon(T2), T2 != T1 + 1.
opposite_times(T1, T2) :- morning(T2), afternoon(T1), T1 != T2 + 1.

% Only have enough allocations for each subject.
N { allocated(C, session(D, T), R) : ses(D, T) : room(R) : T != 4 : T != 5 } N :- per_week(C, N).

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

% Define the days of the week.
day(mon).
day(tues).
day(wed).
day(thurs).
day(fri).

day_time(X, 1..9) :- day(X), X != wed.
day_time(wed, 1..4).

% Define the sessions in each day.
ses(D, T, W, E) :- day_time(D, T), week_term(W, E).

% Define when the morning and the afternoon is.
morning(1..4).
afternoon(5..9).

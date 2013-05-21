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

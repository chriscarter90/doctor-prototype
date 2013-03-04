day(mon).
day(tue).
day(wed).
day(thu).
day(fri).
day(sat).
day(sun).

weekend(sat).
weekend(sun).

weekday(X) :- day(X), not weekend(X).

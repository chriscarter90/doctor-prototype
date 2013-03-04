day(mon).
day(tues).
day(wed).
day(thurs).
day(fri).

session(wed, 1..4).
session(X, 1..9) :- day(X), X != wed.

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
course("111").
course("112").
course("113").
course("114").
course("115").
course("116").
course("117").
course("118").
course("119").
course("120").

room("308").
room("311").
room("144").
room("145").

lecturer("abc1").
lecturer("bcd2").
lecturer("cde3").
lecturer("def4").

teaches("101", "abc1").
teaches("102", "bcd2").
teaches("103", "cde3").
teaches("104", "bcd2").
teaches("105", "cde3").
teaches("106", "def4").
teaches("107", "def4").
teaches("120", "def4").

per_week(C, 3) :- course(C).

N { allocated(C, session(D, T), R) : session(D, T) : room(R) } N :- per_week(C, N).

:- allocated(C, session(D, T), R1), allocated(C, session(D, T), R2), R1 != R2.
:- allocated(C1, session(D, T), R), allocated(C2, session(D, T), R), C1 != C2.
:- allocated(C1, session(D, T), R1), allocated(C2, session(D, T), R2), teaches(C1, L1), teaches(C2, L2), L1 != L2.

#hide.
#show allocated/3.

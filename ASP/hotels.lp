1 { hotel(1..5) } 1.

%* Hotel star ratings *%
star(1,5).
star(2,4).
star(3,3).
star(4,3).
star(5,2).

%* Hotel costs *%
cost(1,170).
cost(2,140).
cost(3,90).
cost(4,75).
cost(5,60).

%* Hotel 4 is on the main street *%
main_street(4).

%* Being on the main street causes noise *%
noisy :- hotel(X), main_street(X).

%* Priority 1 (lowest) - maximise the star rating *%
#maximise [ hotel(X) : star(X,Y) = Y @ 1].

%* Priority 2 (middle) - minimise cost / star ratio *%
#minimise [ hotel(X) : cost(X,Y) : star(X,Z) = Y/Z @ 2].

%* Priority 1 (highest) - we don't want noise *%
#minimise { noisy @ 3 }.

#hide.
#show hotel/1.

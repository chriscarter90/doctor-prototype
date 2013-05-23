never_clash(X, Y) :- b1(X), b1(Y), X != Y, not clash_exception(X, Y).
never_clash(X, Y) :- b2(X), b2(Y), X != Y, not clash_exception(X, Y).
never_clash(X, Y) :- b3(X), b3(Y), X != Y, not clash_exception(X, Y).
never_clash(X, Y) :- b4(X), b4(Y), X != Y, not clash_exception(X, Y).

%% Clash exceptions are ALLOWED to clash, doesn't mean that they SHOULD.
clash_exception(X, Y) :- clash_exception(Y, X).

%% TEMPORARY to allow the timetable to not be over constrained
clash_exception(X, Y) :- b4(X), b4(Y), X != Y.

%% Only clash if they're compabible and we want to.
clash_together(X, Y) :- clash_compatible(X, Y), clash_wanted(X, Y).

%% Check for clash compatibility.
clash_compatible(X, Y) :- course_type(X, T), course_type(Y, T).

%% Clash wanted means we want to put them together.
clash_wanted("333", "470").

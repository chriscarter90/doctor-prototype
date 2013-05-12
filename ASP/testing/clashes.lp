clash("480", "343").
clash(X, Y) :- clash(Y, X).

never_clash(X, Y) :- b3(X), b3(Y), X != Y.
never_clash(X, Y) :- b4(X), b4(Y), X != Y, not clash_exception(X, Y).

clash_exception(X, Y) :- clash_exception(Y, X).
clash_exception("438", "484").

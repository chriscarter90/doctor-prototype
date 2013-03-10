% Define which courses CANNOT be scheduled concurrently,
% Ensuring a reflexive relationship.

unclashable(C1, C2) :- unclashable(C2, C1).
unclashable("105","101").
unclashable("104","105").

strictly_not_before_violated(C, T) :- strictly_not_before(C, T), allocated(C, session(_, T1, _, _), _), T1 < T.
strictly_not_after_violated(C, T) :- strictly_not_after(C, T), allocated(C, session(_, T1, _, _), _), T1 > T.

strictly_not_before_time_day_violated(C, T, D) :- strictly_not_before_time_day(C, T, D), allocated(C, session(D, T1, _, _), _), T1 < T.
strictly_not_after_time_day_violated(C, T, D) :- strictly_not_after_time_day(C, T, D), allocated(C, session(D, T1, _, _), _), T1 > T.

preference_time_met(C, T) :- allocated(C, session(_, T, _, _), _), prefer_time(C, T).
preference_day_met(C, D) :- allocated(C, session(D, _, _, _), _), prefer_day(C, D).

prefer_not_time_violated(C, T) :- allocated(C, session(_, T, _, _), _), prefer_not_time(C, T).
prefer_not_day_violated(C, D) :- allocated(C, session(D, _, _, _), _), prefer_not_day(C, D).

prefer_not_before_violated(C, T) :- allocated(C, session(_, T1, _, _), _), prefer_not_before(C, T), T1 < T.
prefer_not_after_violated(C, T) :- allocated(C, session(_, T1, _, _), _), prefer_not_after(C, T), T1 > T.

precisely_violated(C, D, T) :- precisely(C, D, T), not alloc_gen(C, D, T).



%% Preferences

% Strictly not before a time on any day:

% strictly_not_before("471", 4).
% strictly_not_before("474", 4).


% Strictly not after a time on any day:

% strictly_not_after("471", 8).
% strictly_not_after("474", 7).


% Strictly not after a time on a particular day:

% strictly_not_after_time_day("470", 8, thurs).


% Strictly not before a time on a particular day:

% strictly_not_before_time_day("438", 4, fri).


% I prefer a certain time or day:

% prefer_time("499", 1).
% prefer_day("499", fri).


% I prefer not to have a certain time or day:

% prefer_not_time("452", 1).
% prefer_not_day("452", thurs).


% I prefer not before:

% prefer_not_before("484", 2).


% I prefer not after:

% prefer_not_after("484", 8).


% Precisely...:
% precisely("493", mon, 1).

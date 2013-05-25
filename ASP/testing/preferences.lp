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

% prefer_time("493", 1).
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
precisely("333", fri, 9, lab).

%% Add preference clauses to suit lecturer/course requirements. There are many types - adhere to the syntax.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Strictly not before a time on any day:
%% strictly_not_before(course, time).
%% For example, course 471 should definitely not be before lunchtime:
%% strictly_not_before("471", 4).
%% Or course 474 should not be before 10am:
%% strictly_not_before("474", 2).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Strictly not after a time on any day:
%% strictly_not_after(course, time).
%% For example, course 471 should definitely not be after lunchtime:
%% strictly_not_before("471", 4).
%% Or course 474 should not be after 4pm:
%% strictly_not_before("474", 8).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Strictly not before a time on a particular day:
%% strictly_not_before_time_day(course, time, day).
%% For example, course 471 should definitely not be before lunchtime, but only on Thursdays:
%% strictly_not_before_time_day("471", 4, 4).
%% Or course 474 should not be before 10am, on Mondays:
%% strictly_not_before_time_day("474", 2, 1).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Strictly not after a time on a particular day:
%% strictly_not_after_time_day(course, time, day).
%% For example, course 471 should definitely not be after lunchtime, but only on Thursdays:
%% strictly_not_after_time_day("471", 4, 4).
%% Or course 474 should not be after 4pm, on Mondays:
%% strictly_not_after_time_day("474", 8, 1).






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Preference of a particular day:
%% prefer_day(course, day).
%% For example, course 471 prefers Tuesdays:
%% prefer_day("471", 2).
%% Or course 474 prefers Thursdays:
%% prefer_day("474", 4).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Preference of a particular time:
%% prefer_time(course, time).
%% For example, course 471 prefers 9am:
%% prefer_time("471", 1).
%% Or course 474 prefers 5pm:
%% prefer_time("474", 9).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prefer not a particular day:
%% prefer_not_day(course, day).
%% For example, course 471 dislikes Friday:
%% prefer_not_day("471", 5).
%% Or course 474 dislikes Mondays:
%% prefer_not_day("474", 1).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prefer not a particular time:
%% prefer_not_time(course, time).
%% For example, course 471 dislikes 9am:
%% prefer_not_time("471", 1).
%% Or course 474 dislikes 5pm:
%% prefer_not_time("474", 9).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prefer not before a certain time:
%% prefer_not_before(course, time).
%% For example, course 471 prefers not before 11am:
%% prefer_not_before("471", 3).
%% Or course 474 prefers not before lunch:
%% prefer_not_before("474", 4).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prefer not after a certain time:
%% prefer_not_after(course, time).
%% For example, course 471 prefers not after lunch:
%% prefer_not_before("471", 4).
%% Or course 474 prefers not after 4pm:
%% prefer_not_before("474", 8).






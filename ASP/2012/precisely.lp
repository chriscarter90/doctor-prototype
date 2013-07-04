%% Add clauses to fix slots. There are three types - adhere to the syntax.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TYPE 1 - Format:
%% precisely(course, day, time).
%% For example, to fix course 112 to have the first slot on Monday:
%% precisely("112", 1, 1).
%% Or course 113 to have the last slot on Friday:
%% precisely("113", 5, 9).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TYPE 2 - Format:
%% precisely(course, day, time, type).
%% For example, to fix course 112 to have a lecture on the first slot on Monday:
%% precisely("112", 1, 1, lecture).
%% Or course 120.1 to have a lab on the third slot on Wednesday:
%% precisely("120.1", 3, 3, lab).
%% Valid types: lecture, tutorial, lab.





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TYPE 3 - Format:
%% precisely(course, day, time, term, type).
%% For example, to fix course 112 to have a lecture on the first slot on Monday in term 1 only:
%% precisely("112", 1, 1, 1, lecture).
%% Or course 120.1 to have a lab on the third slot on Wednesday in terms 2 and 3:
%% precisely("120.1", 3, 3, 2, lab).
%% precisely("120.1", 3, 3, 3, lab).
%% Valid types: lecture, tutorial, lab.

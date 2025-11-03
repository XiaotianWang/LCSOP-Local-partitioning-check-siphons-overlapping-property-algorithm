function [ProblemSet_tilde] = Partition(ProblemSet,Siphon)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
ProblemSet_tilde = [];
CurrentProblem = ProblemSet{1};
ProblemSet(1) = [];
Pin = CurrentProblem{2};
Pout = CurrentProblem{3};
P_tilde = setdiff(Siphon,Pin);

while ~isempty(P_tilde) && isempty(intersect(Pout,Pin))
    p = P_tilde(end);
    CurrentProblem{2} = Pin;
    CurrentProblem{3} = union(Pout,p);
    ProblemSet_tilde{end+1} = CurrentProblem;
    P_tilde(end)= [];
    Pin = union(Pin,p);
end

ProblemSet_tilde = horzcat(ProblemSet_tilde,ProblemSet);
end
function [SOP] = SolveList_LCSOP(G,ProblemSet,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
SOP = true;

SiphonSet = [];

while ~isempty(ProblemSet)
    CurrentProblem = ProblemSet{1};
    ProblemSet(1) = [];

    [Siphon,CurrentProblem] = FindSiphon(CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);

    if ~isempty(Siphon)
        [Siphon,SOP] = CheckSOP(G,Siphon,CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);
        if ~SOP
            return;
        end
        
        ProblemSet = cat(2,{CurrentProblem},ProblemSet);
        ProblemSet = Partition(ProblemSet,Siphon);
    end

end
end
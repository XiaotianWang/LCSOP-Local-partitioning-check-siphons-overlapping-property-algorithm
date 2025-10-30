function [SOP] = SolveList_DCSOPL(G,ProblemSet,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
SOP = true;

SiphonSet = [];

while ~isempty(ProblemSet)
    CurrentProblem = ProblemSet{1};
    ProblemSet(1) = [];

    [Siphon,CurrentProblem] = FindSiphon_DCSOP_L(CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);

    if ~isempty(Siphon)
        [Siphon,SOP] = FindMSAndCheck_L(G,Siphon,CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);
        if ~SOP
            return;
        end
        
        ProblemSet = cat(2,{CurrentProblem},ProblemSet);
        ProblemSet = Partition_DCSOPL(ProblemSet,Siphon);
    end

end
end
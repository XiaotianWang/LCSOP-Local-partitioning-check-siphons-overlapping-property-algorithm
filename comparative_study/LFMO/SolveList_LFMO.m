function [SiphonSet] = SolveList_LFMO(ProblemSet,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


SiphonSet = [];

while ~isempty(ProblemSet)
    CurrentProblem = ProblemSet{1};
    ProblemSet(1) = [];

    [Siphon,CurrentProblem] = FindSiphon_LFMO(CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);

    if ~isempty(Siphon)
        Pin = CurrentProblem{2};

        if ~isequal(Siphon,Pin)
            Siphon = FindMinimalSiphon_LFMO(CurrentProblem,Trans_Input,Trans_Output,Nodes_Output,Nodes_Input);
        end

        SiphonSet{end+1} = Siphon;
        ProblemSet = cat(2,{CurrentProblem},ProblemSet);
        ProblemSet = Partition_LFMO(ProblemSet,Siphon);
    end

end
end
function [SOP] = SolveList_LPMSEm(SiphonSet_old,ProblemSet,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
SOP = true;

SiphonSet = [];

while ~isempty(ProblemSet)
    CurrentProblem = ProblemSet{1};
    ProblemSet(1) = [];

    [Siphon,CurrentProblem] = FindSiphon(CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);

    if ~isempty(Siphon)
        Pin = CurrentProblem{2};

        if ~isequal(Siphon,Pin)
            Siphon = FindMinimalSiphon(CurrentProblem,Trans_Input,Trans_Output,Nodes_Output,Nodes_Input);
        end

        for i = 1:size(SiphonSet_old,2)
            if ~any(ismember(Siphon,SiphonSet_old{i}))
                SOP = false;
                return;
            end
        end

        for i = 1:size(SiphonSet,2)
            if ~any(ismember(Siphon,SiphonSet{i}))
                SOP = false;
                return;
            end
        end

        Flag_MinSiphon = true;
        index = 1;
        while i >size(SiphonSet,2)
            if all(ismember(SiphonSet{i},Siphon))
                Flag_MinSiphon = false;
                break;
            elseif all(ismember(Siphon,SiphonSet{i}))
                SiphonSet(i) = [];
                i = i-1;
            end
            i = i+1;
        end

        if Flag_MinSiphon
            SiphonSet{end+1} = Siphon;
        end
        ProblemSet = cat(2,{CurrentProblem},ProblemSet);
        ProblemSet = Partition(ProblemSet,Siphon);
    end

end
end
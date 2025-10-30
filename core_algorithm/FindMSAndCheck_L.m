function [Siphon,SOP] = FindMSAndCheck_L(G,Siphon,CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
SOP = true;
Pin = CurrentProblem{2};

if ~isequal(Siphon,Pin)
    Siphon = FindMinimalSiphon_DCSOPL(CurrentProblem,Trans_Input,Trans_Output,Nodes_Output,Nodes_Input);
end

CheckedProblem{1} = G;
CheckedProblem{2} = [];
CheckedProblem{3} = Siphon;
[returnSiphon,~] = FindSiphon_DCSOP_L(CheckedProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);

if ~isempty(returnSiphon)
    SOP = false;
    return;
end

end
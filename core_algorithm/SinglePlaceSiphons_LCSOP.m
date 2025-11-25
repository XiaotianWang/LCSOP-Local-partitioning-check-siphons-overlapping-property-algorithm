function [Flag_SingleSiphon,SOP]=SinglePlaceSiphons_LCSOP(G,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
SOP = true;
Flag_SingleSiphon = false;
P_tilde = G{1};

while ~isempty(P_tilde)
    p = P_tilde(end);
    P_tilde(end) = [];
    if isempty(Nodes_Input{p})
        Flag_SingleSiphon = true;
        CheckedProblem{1} = G;
        CheckedProblem{2} = [];
        CheckedProblem{3} = p;
        [returnSiphon,~] = FindSiphon(CheckedProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);

        if ~isempty(returnSiphon)
            SOP = false;
        end
        return;
    end
end

end
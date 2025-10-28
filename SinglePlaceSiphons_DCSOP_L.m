function [SiphonSet,Pout,SOP]=SinglePlaceSiphons_DCSOP_L(G,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
SOP = true;
SiphonSet = [];
P_tilde = G{1};
Pout = [];

while ~isempty(P_tilde)
    p = P_tilde(end);
    if isempty(Nodes_Input{p})
        CheckedProblem{1} = G;
        CheckedProblem{2} = [];
        CheckedProblem{3} = p;
        [returnSiphon,~] = FindSiphon_DCSOP(CheckedProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);

        if ~isempty(returnSiphon)
            SOP = false;
            return;
        end
        SiphonSet{end+1} = p;
        Pout(end+1) = p;
    end
    P_tilde(end) = [];
end

end
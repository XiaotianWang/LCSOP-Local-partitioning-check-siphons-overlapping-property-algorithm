function [Siphon] = FindMinimalSiphon_DCSOPL(CurrentProblem,Trans_Input,Trans_Output,Nodes_Output,Nodes_Input)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
P = CurrentProblem{1}{1};
Pin = CurrentProblem{2};
Siphon = P;
P_tilde = setdiff(Siphon,Pin);

while ~isempty(P_tilde)
    p = P_tilde(end);
    T = Nodes_Output{p};
    flag = true;
    for j = T
        temp_intersect = intersect(Trans_Input{j},Siphon);
        temp_flag = size(temp_intersect,2)>1 && ismember(p,temp_intersect);
        if temp_flag || isempty(intersect(Trans_Output{j},Siphon))

        else
            flag = false;
        end
    end

    if flag
        Siphon = setdiff(Siphon,p);
    end

    P_tilde(end) = [];
end

P_tilde = setdiff(Siphon,Pin);
Pin_tilde = Pin;

while ~isempty(P_tilde)
    p = P_tilde(end);
    G_tilde = red_DCSOP_L(CurrentProblem{1},setdiff(Siphon,p),Trans_Input,Trans_Output);
    CurrentProblem_tilde{1} = G_tilde;
    CurrentProblem_tilde{2} = Pin_tilde;
    CurrentProblem_tilde{3} = [];

    [Siphon_tilde,CurrentProblem_tilde] = FindSiphon_DCSOP_L(CurrentProblem_tilde,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);
    if ~isempty(Siphon_tilde)
        Siphon = Siphon_tilde;
        P_tilde = setdiff(Siphon,Pin_tilde);
        CurrentProblem{1} = G_tilde;
    else
        P_tilde(end) = [];
        Pin_tilde(end+1) = p;
    end

end

end
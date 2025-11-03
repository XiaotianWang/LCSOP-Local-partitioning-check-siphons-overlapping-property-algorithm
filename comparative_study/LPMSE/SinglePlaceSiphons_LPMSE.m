function [SiphonSet,Pout]=SinglePlaceSiphons_LPMSE(G,Nodes_Input)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
SiphonSet = [];
P_tilde = G{1};
Pout = [];

while ~isempty(P_tilde)
    p = P_tilde(end);
    if isempty(Nodes_Input{p})
        SiphonSet{end+1} = p;
        Pout(end+1) = p;
    end
    P_tilde(end) = [];
end

end
function [SiphonSet,Pout,SOP]=SinglePlaceSiphons_LDMSN(G,Nodes_Input)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
SOP = true;
SiphonSet = [];
P_tilde = G{1};
Pout = [];

while ~isempty(P_tilde)
    p = P_tilde(end);
    if isempty(Nodes_Input{p})
        for i = 1:size(SiphonSet,2)
            if ~ismember(p,SiphonSet{i})
                SOP = false;
                return;
            end
        end
        SiphonSet{end+1} = p;
        Pout(end+1) = p;
    end
    P_tilde(end) = [];
end

end
function [Gout] = red_DCSOP_L(G,P,Trans_Input,Trans_Output)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Gout = G;
T = G{2};
Tout = [];

for i = T
    if ~isempty(intersect(union(Trans_Input{i},Trans_Output{i}),P))
        Tout(end+1)=i;
    end
end

Gout{1} = P;
Gout{2} = Tout;
end
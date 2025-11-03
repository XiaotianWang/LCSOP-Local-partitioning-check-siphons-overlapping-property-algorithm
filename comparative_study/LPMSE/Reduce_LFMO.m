function [isReducible,CurrentProblem_Out] = Reduce_LFMO(CurrentProblem,Trans_Input,Trans_Output,Nodes_Input,Nodes_Output)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
CurrentProblem_Out = CurrentProblem;
isReducible = true;

T_line = [];
P_line = [];

for i = CurrentProblem{1}{2}
    if isempty(intersect(Trans_Input{i},CurrentProblem{1}{1}))
        T_line(end+1)=i;
    end
end

P_line = horzcat(Trans_Output{T_line});

Pin = CurrentProblem{2};
Pout = CurrentProblem{3};
P = CurrentProblem{1}{1};
T_hat = [];
for i = setdiff(horzcat(Nodes_Input{Pin}),horzcat(Nodes_Output{Pin}))
    if ~isempty(i) && size(Trans_Input{i},2)==1
        T_hat(end+1) = i;
    end
end

P_hat = intersect(horzcat(Trans_Input{T_hat}),setdiff(P,Pin));

if isempty(P_line) && isempty(P_hat)
    isReducible = false;
else
    CurrentProblem_Out{2} = union(Pin,P_hat);
    CurrentProblem_Out{3} = reshape(union(Pout,P_line),1,[]);
end

if size(CurrentProblem_Out{3},1)>1
    error
end

end
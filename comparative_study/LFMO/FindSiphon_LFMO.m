function [Siphon,CurrentProblem_Red] = FindSiphon_LFMO(CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
CurrentProblem_Red = CurrentProblem;
isReducible = true;

while isReducible
    Pin = CurrentProblem_Red{2};
    Pout = CurrentProblem_Red{3};
    P = CurrentProblem_Red{1}{1};
    if ~isempty(intersect(Pin,Pout))
        Siphon = [];

        return
    elseif isequal(unique(union(Pin,Pout)),unique(P))
        if all(ismember(horzcat(Nodes_Input{Pin}),horzcat(Nodes_Output{Pin})))
            Siphon = Pin;
        else
            Siphon = [];
        end
        return
    end

    if ~isempty(Pout)
        G = red_LFMO(CurrentProblem_Red{1},setdiff(P,Pout),Trans_Input,Trans_Output);
        % CurrentProblem_Red = [G,Pin,[]];
        CurrentProblem_Red{1} = G;
        CurrentProblem_Red{2} = Pin;
        CurrentProblem_Red{3} = [];
    end
    [isReducible,CurrentProblem_Red] = Reduce_LFMO(CurrentProblem_Red,Trans_Input,Trans_Output,Nodes_Input,Nodes_Output);

end

Siphon = CurrentProblem_Red{1}{1};
end
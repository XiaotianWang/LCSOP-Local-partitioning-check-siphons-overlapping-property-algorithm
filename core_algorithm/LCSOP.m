function [SOP] = LCSOP(Pre,Post)
% LCSOP Summary of this function goes here
% This is the first algorithm for verifying the siphon overlapping
% property. Some of functions are from the
% R. Cordone, L. Ferrarini, and L. Piroddi, “Enumeration algorithms
% for minimal siphons in petri nets based on place constraints,” IEEE
% Transactions on Systems, Man, and Cybernetics-Part A: Systems and
% Humans, vol. 35, no. 6, pp. 844–854, 2005.

% The idea of this algorithm is that:
% First, find one siphon, named target siphon, in the Petri Net;
% Then, try to find another siphon in the Petri Net without the target
% siphon;
% repeat the above two steps until finishing the verifying for all siphons.

% Author: Xiaotian Wang, David Angeli.


PreList = logical(Pre);
PostList = logical(Post);
[Num_Node, Num_Tran] = size(Pre);
Nodes_Input = cell(1,Num_Node);
Nodes_Output = cell(1,Num_Node);
Trans_Input = cell(1,Num_Tran);
Trans_Output = cell(1,Num_Tran);

for i=1:Num_Node
    for j = 1:Num_Tran
        if PostList(i,j)
            Nodes_Input{i} = [Nodes_Input{i},j];
            Trans_Output{j} = [Trans_Output{j},i];
        end

        if PreList(i,j)
            Nodes_Output{i} = [Nodes_Output{i},j];
            Trans_Input{j} = [Trans_Input{j},i];
        end
    end
end

P = 1:Num_Node;
T = 1:Num_Tran;
G{1} = P;
G{2} = T;

%%
SOP = true;
Flag_SingleSiphon = false;
[Flag_SingleSiphon,SOP]=SinglePlaceSiphons_LCSOP(G,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);
if Flag_SingleSiphon
    return;
end
CurrentProblem{1} = G;
CurrentProblem{2} = [];
CurrentProblem{3} = [];

% [Siphon,CurrentProblem] = FindAndCheck(CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);

[Siphon,CurrentProblem] = FindSiphon(CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);

if ~isempty(Siphon)
    [Siphon,SOP] = FindMSAndCheck_L(G,Siphon,CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);
    if ~SOP
        return;
    end
end

Max_M = floor(size(Siphon,2)/2);

for i = 1:Max_M
    ComProblemSet = nchoosek(Siphon,i);

    for j = 1:size(ComProblemSet,1)
        CheckedProblem{1} = G;
        CheckedProblem{2} = ComProblemSet(j,:);
        CheckedProblem{3} = setdiff(Siphon,CheckedProblem{2});

        ProblemSet{1} = CheckedProblem;
        SOP = SolveList_LCSOP(G,ProblemSet,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);
        if ~SOP
            return;
        end
    end
    
end




end


%% test data 
%{
case 1              done
Pre = [1,0,0;0,1,0;0,0,1];
Post = [0,0,1;1,0,0;0,1,0];
[Flag] = LCSOP(Pre,Post);

case 2          done
Pre = [1,0,0,0,0;0,1,0,0,1;0,0,1,0,0;0,0,0,1,0];
Post = [0,0,1,1,0;1,0,0,0,0;0,1,0,0,0;0,0,0,0,1];
[Flag] = LCSOP(Pre,Post);
%}

%{
case 3      done
Pre =[1,0,0,0,0,0;0,1,0,0,0,0;0,0,1,1,0,0;
0,0,0,0,1,0;0,0,0,0,1,0;0,0,0,0,0,1];
Post =[0,0,0,0,0,1;1,0,0,0,0,0;0,1,0,0,0,0;
0,0,1,0,0,0;0,0,0,1,0,0;0,0,0,0,1,0];
[Flag] = LCSOP(Pre,Post);
%}

%{
case 4      done
Pre = [1,0,0,0,0,0;0,1,0,0,0,0;0,0,1,1,0,0;0,0,0,0,1,0;0,0,0,0,0,1];
Post = [0,0,0,0,0,1,;1,0,0,1,0,0;0,1,0,0,0,0;0,0,1,0,0,0;0,0,0,0,1,0];
[Flag] = LCSOP(Pre,Post);

case 5      done
Pre = [1,0,0,0,0;0,1,0,0,0;1,0,1,0,0;0,0,0,1,0;0,0,0,0,1];
Post = [0,0,0,0,1;1,0,0,0,0;0,1,0,0,0;0,0,1,0,0;0,0,0,1,0];
[Flag] = LCSOP(Pre,Post);

case 6     done
Pre = [1,0,0,0,0,0,0,0,0;0,1,0,0,0,0,0,0,0;0,0,1,0,0,0,0,1,0;
0,0,0,1,0,1,0,0,0;0,0,0,0,1,0,0,0,0;0,0,0,0,0,0,1,0,0;
0,0,0,0,0,0,0,0,1];
Post = [0,0,0,0,1,0,1,0,0;1,0,0,0,0,0,0,0,1;0,1,0,0,0,0,0,0,0;
0,0,1,0,0,0,0,0,0;0,0,0,1,0,0,0,0,0;0,0,0,0,0,1,0,0,0;
0,0,0,0,0,0,0,1,0];
[Flag] = LCSOP(Pre,Post);

case 7
Pre = [1,0,0,0,0,0,0;0,1,0,0,0,0,0;0,0,1,1,1,0,0;0,0,0,0,0,1,0;
0,0,0,0,0,1,0;0,0,0,0,0,1,0;0,0,0,0,0,0,1];
Post = [0,0,0,0,0,0,1;1,0,0,0,0,0,0;0,1,0,0,0,0,0;
0,0,1,0,0,0,0;0,0,0,1,0,0,0;0,0,0,0,1,0,0;0,0,0,0,0,1,0];
[Flag] = LCSOP(Pre,Post);

case 8
Pre = [1,0,0,1;0,1,0,0;0,0,1,0;0,0,1,0];
Post = [0,0,1,0;1,0,0,0;0,1,0,0;0,0,0,1];
[Flag] = LCSOP(Pre,Post);

case 9
Pre =[1,0,0,0,0,0,0;0,1,0,0,0,0,0;0,0,1,0,0,0,0;
0,0,0,1,0,0,0;0,0,0,0,1,0,1;0,0,0,0,0,1,0];
Post =[0,0,1,1,0,0,0;1,0,0,0,0,0,0;0,1,0,0,0,0,0;
0,0,0,0,1,0,0;0,0,0,0,0,1,0;0,0,0,0,0,0,1];
[Flag] = LCSOP(Pre,Post);


case 10
Pre = [1,0,0,0,0,0,0,0,0;0,1,0,1,0,0,0,0,0;0,0,1,0,0,0,0,1,0;
0,0,0,0,1,0,0,0,0;0,0,0,0,0,1,0,0,0;0,0,0,0,0,0,1,0,0;
0,0,0,0,0,0,0,0,1];
Post = [0,0,1,0,0,0,0,0,0;1,0,0,0,0,0,1,0,0;0,1,0,0,0,0,0,0,0;
0,0,0,1,0,0,0,0,0;0,0,0,0,1,0,0,0,1;0,0,0,0,0,1,0,0,0;
0,0,0,0,0,0,0,1,0];
[Flag] = LCSOP(Pre,Post);

case 11
Pre = [1,0,0,1,0,0,0,0;0,1,0,0,0,0,1,0;0,0,1,0,0,0,0,0;
0,0,0,0,1,0,0,0;0,0,0,0,0,1,0,0;0,0,1,0,0,0,0,0;
0,0,0,0,0,0,0,1];
Post = [0,0,1,0,0,0,0,0;1,0,0,0,0,0,0,0;0,1,0,0,0,0,0,0;
0,0,0,1,0,0,0,0;0,0,0,0,1,0,0,1;0,0,0,0,0,1,0,0;
0,0,0,0,0,0,1,0];
[Flag] = LCSOP(Pre,Post);

case 12
Pre = [1,0,0,0,0,0;0,1,0,0,0,0;0,0,1,0,0,0;0,0,0,1,0,1;0,0,0,0,1,0];
Post = [0,0,1,1,0,0;1,0,0,0,0,0;0,1,0,0,0,0;0,0,0,0,1,0;0,0,0,0,0,1];
[Flag] = LCSOP(Pre,Post);

case 13
Pre = [1,0,0,0,0;0,1,1,0,0;0,0,1,0,1;0,0,0,1,0];
Post = [0,0,1,0,0;1,0,0,0,0;0,1,0,1,0;0,0,0,0,1];
[Flag] = LCSOP(Pre,Post);

case 14
Pre = [1,1;0,1];
Post = [1,0;0,1];
[Flag] = LCSOP(Pre,Post);

case 15
Pre = [1,0,0,0;0,1,0,1;0,1,1,0;0,0,0,1];
Post = [0,1,0,0;1,0,0,0;0,0,0,1;0,0,1,0];
[Flag] = LCSOP(Pre,Post);

Case for the conference paper
Pre = [0,1,1,0;0,1,1,1;0,0,0,1;0,0,1,0;1,1,0,0];
Post = [0,0,0,1;1,0,0,0;1,1,0,0;1,1,0,1;0,0,1,0];
[Flag] = LCSOP(Pre,Post);


%}
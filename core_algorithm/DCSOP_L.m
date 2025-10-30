function [SOP] = DCSOP_L(Pre,Post)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
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
[~,Pout,SOP]=SinglePlaceSiphons_DCSOP_L(G,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);
if ~SOP
    return;
end
CurrentProblem{1} = G;
CurrentProblem{2} = [];
CurrentProblem{3} = Pout;

% [Siphon,CurrentProblem] = FindAndCheck(CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);

[Siphon,CurrentProblem] = FindSiphon_DCSOP_L(CurrentProblem,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);

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
        SOP = SolveList_DCSOPL(G,ProblemSet,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output);
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
[Flag] = DCSOP_L(Pre,Post);

case 2          done
Pre = [1,0,0,0,0;0,1,0,0,1;0,0,1,0,0;0,0,0,1,0];
Post = [0,0,1,1,0;1,0,0,0,0;0,1,0,0,0;0,0,0,0,1];
[Flag] = DCSOP_L(Pre,Post);
%}

%{
case 3      done
Pre =[1,0,0,0,0,0;0,1,0,0,0,0;0,0,1,1,0,0;
0,0,0,0,1,0;0,0,0,0,1,0;0,0,0,0,0,1];
Post =[0,0,0,0,0,1;1,0,0,0,0,0;0,1,0,0,0,0;
0,0,1,0,0,0;0,0,0,1,0,0;0,0,0,0,1,0];
[Flag] = DCSOP_L(Pre,Post);
%}

%{
case 4      done
Pre = [1,0,0,0,0,0;0,1,0,0,0,0;0,0,1,1,0,0;0,0,0,0,1,0;0,0,0,0,0,1];
Post = [0,0,0,0,0,1,;1,0,0,1,0,0;0,1,0,0,0,0;0,0,1,0,0,0;0,0,0,0,1,0];
[Flag] = DCSOP_L(Pre,Post);

case 5      done
Pre = [1,0,0,0,0;0,1,0,0,0;1,0,1,0,0;0,0,0,1,0;0,0,0,0,1];
Post = [0,0,0,0,1;1,0,0,0,0;0,1,0,0,0;0,0,1,0,0;0,0,0,1,0];
[Flag] = DCSOP_L(Pre,Post);

case 6     done
Pre = [1,0,0,0,0,0,0,0,0;0,1,0,0,0,0,0,0,0;0,0,1,0,0,0,0,1,0;
0,0,0,1,0,1,0,0,0;0,0,0,0,1,0,0,0,0;0,0,0,0,0,0,1,0,0;
0,0,0,0,0,0,0,0,1];
Post = [0,0,0,0,1,0,1,0,0;1,0,0,0,0,0,0,0,1;0,1,0,0,0,0,0,0,0;
0,0,1,0,0,0,0,0,0;0,0,0,1,0,0,0,0,0;0,0,0,0,0,1,0,0,0;
0,0,0,0,0,0,0,1,0];
[Flag] = DCSOP_L(Pre,Post);

case 7  ???????????????
Pre = [1,0,0,0,0,0,0;0,1,0,0,0,0,0;0,0,1,1,1,0,0;0,0,0,0,0,1,0;
0,0,0,0,0,1,0;0,0,0,0,0,1,0;0,0,0,0,0,0,1];
Post = [0,0,0,0,0,0,1;1,0,0,0,0,0,0;0,1,0,0,0,0,0;
0,0,1,0,0,0,0;0,0,0,1,0,0,0;0,0,0,0,1,0,0;0,0,0,0,0,1,0];
[Flag] = DCSOP_L(Pre,Post);

case 8
Pre = [1,0,0,1;0,1,0,0;0,0,1,0;0,0,1,0];
Post = [0,0,1,0;1,0,0,0;0,1,0,0;0,0,0,1];
[Flag] = DCSOP_L(Pre,Post);

case 9   Wrong!!!!!!
Pre =[1,0,0,0,0,0,0;0,1,0,0,0,0,0;0,0,1,0,0,0,0;
0,0,0,1,0,0,0;0,0,0,0,1,0,1;0,0,0,0,0,1,0];
Post =[0,0,1,1,0,0,0;1,0,0,0,0,0,0;0,1,0,0,0,0,0;
0,0,0,0,1,0,0;0,0,0,0,0,1,0;0,0,0,0,0,0,1];
[Flag] = DCSOP_L(Pre,Post);


case 10
Pre = [1,0,0,0,0,0,0,0,0;0,1,0,1,0,0,0,0,0;0,0,1,0,0,0,0,1,0;
0,0,0,0,1,0,0,0,0;0,0,0,0,0,1,0,0,0;0,0,0,0,0,0,1,0,0;
0,0,0,0,0,0,0,0,1];
Post = [0,0,1,0,0,0,0,0,0;1,0,0,0,0,0,1,0,0;0,1,0,0,0,0,0,0,0;
0,0,0,1,0,0,0,0,0;0,0,0,0,1,0,0,0,1;0,0,0,0,0,1,0,0,0;
0,0,0,0,0,0,0,1,0];
[Flag] = DCSOP_L(Pre,Post);

case 11
Pre = [1,0,0,1,0,0,0,0;0,1,0,0,0,0,1,0;0,0,1,0,0,0,0,0;
0,0,0,0,1,0,0,0;0,0,0,0,0,1,0,0;0,0,1,0,0,0,0,0;
0,0,0,0,0,0,0,1];
Post = [0,0,1,0,0,0,0,0;1,0,0,0,0,0,0,0;0,1,0,0,0,0,0,0;
0,0,0,1,0,0,0,0;0,0,0,0,1,0,0,1;0,0,0,0,0,1,0,0;
0,0,0,0,0,0,1,0];
[Flag] = DCSOP_L(Pre,Post);

case 12
Pre = [1,0,0,0,0,0;0,1,0,0,0,0;0,0,1,0,0,0;0,0,0,1,0,1;0,0,0,0,1,0];
Post = [0,0,1,1,0,0;1,0,0,0,0,0;0,1,0,0,0,0;0,0,0,0,1,0;0,0,0,0,0,1];
[Flag] = DCSOP_L(Pre,Post);

case 13
Pre = [1,0,0,0,0;0,1,1,0,0;0,0,1,0,1;0,0,0,1,0];
Post = [0,0,1,0,0;1,0,0,0,0;0,1,0,1,0;0,0,0,0,1];
[Flag] = DCSOP_L(Pre,Post);

case 14
Pre = [1,1;0,1];
Post = [1,0;0,1];
[Flag] = DCSOP_L(Pre,Post);

case 15
Pre = [1,0,0,0;0,1,0,1;0,1,1,0;0,0,0,1];
Post = [0,1,0,0;1,0,0,0;0,0,0,1;0,0,1,0];
[Flag] = DCSOP_L(Pre,Post);
%}
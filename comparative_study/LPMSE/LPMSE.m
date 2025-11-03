function [SOP] = LPMSE(Pre,Post)
% LPMSE Summary of this function goes here
% This is the algorithm for verifying the siphon overlapping property.
% 

SOP = true;

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

[SiphonSet,Pout]=SinglePlaceSiphons_LPMSE(G,Nodes_Input);
CurrentProblem{1} = G;
CurrentProblem{2} = [];
CurrentProblem{3} = Pout;
ProblemSet{1} = CurrentProblem;

SiphonSet = horzcat(SiphonSet,SolveList_LPMSE(ProblemSet,Nodes_Input,Nodes_Output,Trans_Input,Trans_Output));

%% Finally check the siphon overlapping property.

for i = 1:size(SiphonSet,2)
    for j = i+1:size(SiphonSet,2)
        if ~any(ismember(SiphonSet{i},SiphonSet{j}))
            SOP = false;
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
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);

case 2          done
Pre = [1,0,0,0,0;0,1,0,0,1;0,0,1,0,0;0,0,0,1,0];
Post = [0,0,1,1,0;1,0,0,0,0;0,1,0,0,0;0,0,0,0,1];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);
%}

%{
case 3      done
Pre =[1,0,0,0,0,0;0,1,0,0,0,0;0,0,1,1,0,0;
0,0,0,0,1,0;0,0,0,0,1,0;0,0,0,0,0,1];
Post =[0,0,0,0,0,1;1,0,0,0,0,0;0,1,0,0,0,0;
0,0,1,0,0,0;0,0,0,1,0,0;0,0,0,0,1,0];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);
%}

%{
case 4      done
Pre = [1,0,0,0,0,0;0,1,0,0,0,0;0,0,1,1,0,0;0,0,0,0,1,0;0,0,0,0,0,1];
Post = [0,0,0,0,0,1,;1,0,0,1,0,0;0,1,0,0,0,0;0,0,1,0,0,0;0,0,0,0,1,0];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);

case 5      done
Pre = [1,0,0,0,0;0,1,0,0,0;1,0,1,0,0;0,0,0,1,0;0,0,0,0,1];
Post = [0,0,0,0,1;1,0,0,0,0;0,1,0,0,0;0,0,1,0,0;0,0,0,1,0];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);

case 6     done
Pre = [1,0,0,0,0,0,0,0,0;0,1,0,0,0,0,0,0,0;0,0,1,0,0,0,0,1,0;
0,0,0,1,0,1,0,0,0;0,0,0,0,1,0,0,0,0;0,0,0,0,0,0,1,0,0;
0,0,0,0,0,0,0,0,1];
Post = [0,0,0,0,1,0,1,0,0;1,0,0,0,0,0,0,0,1;0,1,0,0,0,0,0,0,0;
0,0,1,0,0,0,0,0,0;0,0,0,1,0,0,0,0,0;0,0,0,0,0,1,0,0,0;
0,0,0,0,0,0,0,1,0];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);

case 7  ???????????????
Pre = [1,0,0,0,0,0,0;0,1,0,0,0,0,0;0,0,1,1,1,0,0;0,0,0,0,0,1,0;
0,0,0,0,0,1,0;0,0,0,0,0,1,0;0,0,0,0,0,0,1];
Post = [0,0,0,0,0,0,1;1,0,0,0,0,0,0;0,1,0,0,0,0,0;
0,0,1,0,0,0,0;0,0,0,1,0,0,0;0,0,0,0,1,0,0;0,0,0,0,0,1,0];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);

case 8
Pre = [1,0,0,1;0,1,0,0;0,0,1,0;0,0,1,0];
Post = [0,0,1,0;1,0,0,0;0,1,0,0;0,0,0,1];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);

case 9   Wrong!!!!!!
Pre =[1,0,0,0,0,0,0;0,1,0,0,0,0,0;0,0,1,0,0,0,0;
0,0,0,1,0,0,0;0,0,0,0,1,0,1;0,0,0,0,0,1,0];
Post =[0,0,1,1,0,0,0;1,0,0,0,0,0,0;0,1,0,0,0,0,0;
0,0,0,0,1,0,0;0,0,0,0,0,1,0;0,0,0,0,0,0,1];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);


case 10
Pre = [1,0,0,0,0,0,0,0,0;0,1,0,1,0,0,0,0,0;0,0,1,0,0,0,0,1,0;
0,0,0,0,1,0,0,0,0;0,0,0,0,0,1,0,0,0;0,0,0,0,0,0,1,0,0;
0,0,0,0,0,0,0,0,1];
Post = [0,0,1,0,0,0,0,0,0;1,0,0,0,0,0,1,0,0;0,1,0,0,0,0,0,0,0;
0,0,0,1,0,0,0,0,0;0,0,0,0,1,0,0,0,1;0,0,0,0,0,1,0,0,0;
0,0,0,0,0,0,0,1,0];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);

case 11
Pre = [1,0,0,1,0,0,0,0;0,1,0,0,0,0,1,0;0,0,1,0,0,0,0,0;
0,0,0,0,1,0,0,0;0,0,0,0,0,1,0,0;0,0,1,0,0,0,0,0;
0,0,0,0,0,0,0,1];
Post = [0,0,1,0,0,0,0,0;1,0,0,0,0,0,0,0;0,1,0,0,0,0,0,0;
0,0,0,1,0,0,0,0;0,0,0,0,1,0,0,1;0,0,0,0,0,1,0,0;
0,0,0,0,0,0,1,0];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);

case 12
Pre = [1,0,0,0,0,0;0,1,0,0,0,0;0,0,1,0,0,0;0,0,0,1,0,1;0,0,0,0,1,0];
Post = [0,0,1,1,0,0;1,0,0,0,0,0;0,1,0,0,0,0;0,0,0,0,1,0;0,0,0,0,0,1];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);

case 13
Pre = [1,0,0,0,0;0,1,1,0,0;0,0,1,0,1;0,0,0,1,0];
Post = [0,0,1,0,0;1,0,0,0,0;0,1,0,1,0;0,0,0,0,1];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);

case 14
Pre = [1,1;0,1];
Post = [1,0;0,1];
[SOP] = FindAllMinimalSiphons_LFMO(Pre,Post);

case 15
Pre = [1,0,0,0;0,1,0,1;0,1,1,0;0,0,0,1];
Post = [0,1,0,0;1,0,0,0;0,0,0,1;0,0,1,0];
[SOP] = FindAllMinimalSiphons_LFMO(Pre,Post);

case 16
Pre = [0,0,1;0,0,1;1,1,0];
Post = [1,0,0;0,1,0;0,0,1];
[SiphonSet] = FindAllMinimalSiphons_LFMO(Pre,Post);
%}
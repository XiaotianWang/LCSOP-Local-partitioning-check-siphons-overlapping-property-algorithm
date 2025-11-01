function [T1,T2,T3,T1_array,T2_array,T3_array] = Compare(Number_Cases,Number_Nodes,Number_Trans,Probability_Input,Probability_Output)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
T1 = 0;
T2 = 0;
T3 = 0;

T1_array = zeros(1,Number_Cases);
Index = 0;
T2_array = zeros(1,Number_Cases);
T3_array = zeros(1,Number_Cases);

random_temp_Pre = zeros(Number_Nodes,Number_Trans);
random_temp_Post = zeros(Number_Nodes,Number_Trans);
Pre = random_temp_Pre;
Post = random_temp_Post;


for i = 1:Number_Cases

    disp(['iteration = ',num2str(i)]);
    Index = Index+1;

    random_temp_Pre = rand(Number_Nodes,Number_Trans);
    random_temp_Post = rand(Number_Nodes,Number_Trans);
    Pre = random_temp_Pre<Probability_Input;
    Post = random_temp_Post<Probability_Output;
    % Graph = logical(Pre*Post');

    tic
    % [A] = GetAllCycles(Pre,Post);
    [Flag1] = DCSOP_L(Pre,Post);

    temp = toc;
    T1 = T1+temp;
    T1_array(Index) = temp;
    disp('DCSOP is completed');
    tic
    [Flag2] = FindAllMinimalSiphons_LDMSN(Pre,Post);
    temp=toc;
    T2 = T2+temp;
    T2_array(Index) = temp;
    disp('LDMSN is completed');
    tic
    % [Flag3] = FindAllMinimalSiphons_LFMO(Pre,Post);
    temp = toc;
    T3 = T3+temp;
    T3_array(Index) = temp;
    disp('LFMO is completed');

    %
    if ~(Flag1==Flag2)
        stop;
        error('different results');
    end

end

disp([Number_Cases,Number_Nodes,Number_Trans,Probability_Input,Probability_Output]);
currenttime = clock;
disp(currenttime(4:6));
disp([T1,T2,T3]);
end
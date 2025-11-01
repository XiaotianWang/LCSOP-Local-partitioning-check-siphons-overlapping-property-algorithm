# LCSOP: Local-partitioning check siphons overlapping property algorithm
This is the first algorithm to check the siphon overlapping property (SOP) for an original Petri Net.

Authors: Xiaotian Wang, David Angeli.

## Requirements

- **MATLAB R2023b+** (tested on R2023b)


## Quick Start

```matlab
[SOP] = DCSOP_L(Pre,Post)
```

Pre is a matrix of Pre-conditions, while Post is a matrix of Post-conditions.

SOP returns the result. SOP/Flag = 1 -> SOP holds; SOP/Flag = 0 -> SOP failure.

For example:

Pre = [1,0,0;0,1,0;0,0,1];
Post = [0,0,1;1,0,0;0,1,0];
[Flag] = DCSOP_L(Pre,Post);

---

If you want to compare LCSOP with the other two algorithms, LPMSE and LPMSEm, you can:

```matlab
[T1,T2,T3,T1_array,T2_array,T3_array] = Compare(Number_Cases,Number_Nodes,Number_Trans,Probability_Input,Probability_Output)
```

where

| Variable      | Description |
| ----------- | ----------- |
| Number_Cases      | How many comparisons to perform       |
| Number_Nodes   | The number of nodes of the generated Petri Net |
| Number_Trans   | The number of transitions of the generated Petri Net |
| Probability_Input   | Connection probability from a node to a tran |
| Probability_Output   | Connection probability from a tran to a node |



## Notice

We are modifying this project and adding comments to some code.

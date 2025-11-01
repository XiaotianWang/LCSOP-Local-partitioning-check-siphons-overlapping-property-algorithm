# LCSOP: Local-partitioning check siphons overlapping property algorithm
This is the first algorithm to check the siphon overlapping property (SOP) for an original Petri Net.

Authors: Xiaotian Wang, David Angeli.

## Requirements

- **MATLAB R2023b+** (tested on R2023b)


## Quick Start

```matlab
run [SOP] = DCSOP_L(Pre,Post).
```

Pre is a matrix of Pre-conditions, while Post is a matrix of Post-conditions.

SOP returns the result. SOP/Flag = 1 -> SOP holds; SOP/Flag = 0 -> SOP failure.

For example:

Pre = [1,0,0;0,1,0;0,0,1];
Post = [0,0,1;1,0,0;0,1,0];
[Flag] = DCSOP_L(Pre,Post);


## Notice

We are modifying this project and adding comments to some code.

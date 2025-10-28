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

SOP returns the result. SOP = 1 -> SOP holds; SOP = 0 -> SOP failure.

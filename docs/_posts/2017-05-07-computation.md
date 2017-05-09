---
layout: post
title: "Computation Layer"
---

The 6-channels from the first board is passed to the processing layer.
Each computation step (add, sub, threshold) takes place in a separate opamp.
This is very helpful as each phase we can build, test and debug separately.

Using top-down first, and left-right numbering:
```
135
246
```

We use each opamp in the quad package in the following manner:
```
3+4   : 1+2+5+6
2+4+6 : 1+3+5
```

each pair (top, bottom) is fed into the difference amplifier:
```
A = 3+4 - 1+2+5+6
B = 2+4+6 - 1+3+5
```

we used an opamp with no feedback as a comparator for the result of the subtraction with a tweakable bias using a voltage divider.

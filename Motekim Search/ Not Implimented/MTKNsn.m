//
//  MTKNsn.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

/////////////////////////////
//+++++++++++++++++++++++++++
// Not So Naive algorithm
//+++++++++++++++++++++++++++
/////////////////////////////

//+++++++++++++++++++++++++++
// MAIN FEATURES
//+++++++++++++++++++++++++++
//preprocessing phase in constant time and space;
//searching phase in O(nm) time complexity;
//slightly (by coefficient) sub-linear in the average case.

//+++++++++++++++++++++++++++
// MAIN FEATURES
//+++++++++++++++++++++++++++
//preprocessing phase in constant
//During the searching phase of the Not So Naive algorithm the character comparisons are made with the pattern positions in the following order 1, 2, ... , m-2, m-1, 0.
//
//For each attempt where the window is positioned on the text factor y[j .. j+m-1]: if x[0]=x[1] and x[1] neq y[j+1] of if x[0] neq x[1] and x[1]=y[j+1] the pattern is shifted by 2 positions at the end of the attempt and by 1 otherwise.
//
//Thus the preprocessing phase can be done in constant time and space. The searching phase of the Not So Naive algorithm has a quadratic worst case but it is slightly (by coefficient) sub-linear in the average case.

#import "MTKNsn.h"
#include "includeme.h"
@implementation MTKNsn


#define ASIZE   256
void MTKNSN(char *x, char *y, int *output) {
    
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    int j, k, ell;
    int p = 0;
    /* Preprocessing */
    if (x[0] == x[1]) {
        k = 2;
        ell = 1;
    }
    else {
        k = 1;
        ell = 2;
    }
    
    /* Searching */
    j = 0;
    while (j <= n - m)
        if (x[1] != y[j + 1])
            j += k;
        else {
            if (memcmp(x + 2, y + j + 2, m - 2) == 0 &&
                x[0] == y[j])
                output[p] = j;
            p++;
               // OUTPUT(j);
            j += ell;
        }
}


@end

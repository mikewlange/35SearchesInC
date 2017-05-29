//
//  MTKTurboBM.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKTurboBM.h"
#import "includeme.h"
@implementation MTKTurboBM


#define XSIZE   20
#define ASIZE   256
void TBM(char *x, char *y, int *output) {
    
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    int p = 0;
    
    int bcShift, i, j, shift, u, v, turboShift,
    bmGs[XSIZE], bmBc[ASIZE];
    
    /* Preprocessing */
    preBmGsTURBO(x, m, bmGs);
    preBmBcTURBO(x, m, bmBc);
    
    /* Searching */
    j = u = 0;
    shift = m;
    while (j <= n - m) {
        i = m - 1;
        while (i >= 0 && x[i] == y[i + j]) {
            --i;
            if (u != 0 && i == m - 1 - shift)
                i -= u;
        }
        if (i < 0) {
           // OUTPUT(j);
            output[p]=j;
            p++;
            shift = bmGs[0];
            u = m - shift;
        }
        else {
            v = m - 1 - i;
            turboShift = u - v;
            bcShift = bmBc[y[i + j]] - m + 1 + i;
            shift = MAX(turboShift, bcShift);
            shift = MAX(shift, bmGs[i]);
            if (shift == bmGs[i])
                u = MIN(m - shift, v);
            else {
                if (turboShift < bcShift)
                    shift = MAX(shift, u + 1);
                u = 0;
            }
        }
        j += shift;
    }
}

// This is a popular one - I'll find a few versions
// ONE
void preBmBcTURBO(char *x, int m, int bmBc[]) {
    int i;
    for (i = 0; i < ASIZE; ++i)
        bmBc[i] = m;
    for (i = 0; i < m - 1; ++i)
        bmBc[x[i]] = m - i - 1;
}


void suffixesT(char *x, int m, int *suff) {
    int f = 0, g, i;

    suff[m - 1] = m;
    g = m - 1;
    for (i = m - 2; i >= 0; --i) {
        if (i > g && suff[i + m - 1 - f] < i - g)
            suff[i] = suff[i + m - 1 - f];
        else {
            if (i < g)
                g = i;
            f = i;
            while (g >= 0 && x[g] == x[g + m - 1 - f])
                --g;
            suff[i] = f - g;
        }
    }
}

void preBmGsTURBO(char *x, int m, int bmGs[]) {

    int i, j, suff[XSIZE];

    suffixesT(x, m, suff);

    for (i = 0; i < m; ++i)
        bmGs[i] = m;
    j = 0;
    for (i = m - 1; i >= 0; --i)
        if (suff[i] == i + 1)
            for (; j < m - 1 - i; ++j)
                if (bmGs[j] == m)
                    bmGs[j] = m - 1 - i;
    for (i = 0; i <= m - 2; ++i)
        bmGs[m - 1 - suff[i]] = m - 1 - i;
}
@end

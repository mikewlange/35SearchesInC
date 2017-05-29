//
//  MTKZhuTakaoka.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

/////////////////////////////
//+++++++++++++++++++++++++++
// Zhu-Takaoka algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//variant of the Boyer-Moore algorithm;
//uses two consecutive text characters to compute the bad-character shift;
//preprocessing phase in O(m+sigma2) time and space complexity;
//searching phase in O(mn) time complexity.


#import "MTKZhuTakaoka.h"
#import "includeme.h"
@implementation MTKZhuTakaoka
#define XSIZE   20
#define ASIZE   256

void preZtBc(char *x, int m, int ztBc[ASIZE][ASIZE]) {
    int i, j;
    
    for (i = 0; i < ASIZE; ++i)
        for (j = 0; j < ASIZE; ++j)
            ztBc[i][j] = m;
    for (i = 0; i < ASIZE; ++i)
        ztBc[i][x[0]] = m - 1;
    for (i = 1; i < m - 1; ++i)
        ztBc[x[i - 1]][x[i]] = m - 1 - i;
}
void preBmGsZhu(char *x, int m, int bmGs[]) {
    
    
    int i, j, suff[XSIZE];
    
    ztsuffixes(x, m, suff);
    
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

void ztsuffixes(char *x, int m, int *suff) {
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
void ZT(char *x, char *y, int *output) {
    int i, j, ztBc[ASIZE][ASIZE], bmGs[XSIZE];
    
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    int p = 0;
    
    /* Preprocessing */
    preZtBc(x, m, ztBc);
    preBmGsZhu(x, m, bmGs);
    
    /* Searching */
    j = 0;
    while (j <= n - m) {
        i = m - 1;
        while (i < m && x[i] == y[i + j])
            --i;
        if (i < 0) {
            output[p] = j;
            p++;
            j += bmGs[0];
        }
        else
            j += MAX(bmGs[i],
                     ztBc[y[j + m - 2]][y[j + m - 1]]);
    }
}


@end

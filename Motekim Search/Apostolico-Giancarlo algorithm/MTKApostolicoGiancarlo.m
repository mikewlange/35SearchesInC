//
//  MTKApostolicoGiancarlo.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

/////////////////////////////
//+++++++++++++++++++++++++++
// Apostolico-Giancarlo algorithm
//+++++++++++++++++++++++++++
/////////////////////////////

//+++++++++++++++++++++++++++
// MAIN FEATURES
//+++++++++++++++++++++++++++
//variant of the Boyer-Moore algorithm;
//preprocessing phase in O(m+sigma) time and space complexity;
//searching phase in O(n) time complexity;
//3/2n comparisons in the worst case;
// more:http://www-igm.univ-mlv.fr/~lecroq/string/node16.html#SECTION00160

#import "MTKApostolicoGiancarlo.h"
#import "includeme.h"
@implementation MTKApostolicoGiancarlo
#define XSIZE   20
#define ASIZE   256

void AGSearch(char *x, char *y, int*output) {
    int i, j, k, s, shift,
    bmGs[XSIZE], skip[XSIZE], suff[XSIZE], bmBc[ASIZE];
    
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    int p = 0;
    /* Preprocessing */
    preBmGsAG(x, m, bmGs);
    preBmBcAG(x, m, bmBc);
    memset(skip, 0, m*sizeof(int));
    
    /* Searching */
    j = 0;
    while (j <= n - m) {
        i = m - 1;
        while (i >= 0) {
            k = skip[i];
            s = suff[i];
            if (k > 0)
                if (k > s) {
                    if (i + 1 == s)
                        i = (-1);
                    else
                        i -= s;
                    break;
                }
                else {
                    i -= k;
                    if (k < s)
                        break;
                }
                else {
                    if (x[i] == y[i + j])
                        --i;
                    else
                        break;
                }
        }
        if (i < 0) {
          //  OUTPUT(j);
            output[p]=j;
            p++;
            skip[m - 1] = m;
            shift = bmGs[0];
        }
        else {
            skip[m - 1] = m - 1 - i;
            shift = MAX(bmGs[i], bmBc[y[i + j]] - m + 1 + i);
        }
        j += shift;
        memcpy(skip, skip + shift, (m - shift)*sizeof(int));
        memset(skip + m - shift, 0, shift*sizeof(int));
    }
}
void preBmBcAG(char *x, int m, int bmBc[]) {
    int i;
    for (i = 0; i < ASIZE; ++i)
        bmBc[i] = m;
    for (i = 0; i < m - 1; ++i)
        bmBc[x[i]] = m - i - 1;
}


void suffixesAG(char *x, int m, int *suff) {
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

void preBmGsAG(char *x, int m, int bmGs[]) {
    
    
    int i, j, suff[XSIZE];
    
    suffixesAG(x, m, suff);
    
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

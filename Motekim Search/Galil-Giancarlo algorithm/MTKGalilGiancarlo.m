//
//  MTKGalilGiancarlo.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKGalilGiancarlo.h"
#import "includeme.h"

@implementation MTKGalilGiancarlo

#define XSIZE   20
#define ASIZE   256
int preGalilGiancarlo(char *x, int m, int h[], int next[], int shift[]) {
    
    int i, k, nd, q, r = 0, s;
    int hmax[XSIZE], kmin[XSIZE], nhd0[XSIZE], rmin[XSIZE];
    
    /* Computation of hmax */
    i = k = 1;
    do {
        while (x[i] == x[i - k])
            i++;
        hmax[k] = i;
        q = k + 1;
        while (hmax[q - k] + k < i) {
            hmax[q] = hmax[q - k] + k;
            q++;
        }
        k = q;
        if (k == i + 1)
            i = k;
    } while (k <= m);
    
    /* Computation of kmin */
    memset(kmin, 0, m * sizeof(int));
    for (i = m; i >= 1; --i)
        if (hmax[i] < m)
            kmin[hmax[i]] = i;
    
    /* Computation of rmin */
    for (i = m - 1; i >= 0; --i) {
        if (hmax[i + 1] == m)
            r = i + 1;
        if (kmin[i] == 0)
            rmin[i] = r;
        else
            rmin[i] = 0;
    }
    
    /* Computation of h */
    s = -1;
    r = m;
    for (i = 0; i < m; ++i)
        if (kmin[i] == 0)
            h[--r] = i;
        else
            h[++s] = i;
    nd = s;
    
    /* Computation of shift */
    for (i = 0; i <= nd; ++i)
        shift[i] = kmin[h[i]];
    for (i = nd + 1; i < m; ++i)
        shift[i] = rmin[h[i]];
    shift[m] = rmin[0];
    
    /* Computation of nhd0 */
    s = 0;
    for (i = 0; i < m; ++i) {
        nhd0[i] = s;
        if (kmin[i] > 0)
            ++s;
    }
    
    /* Computation of next */
    for (i = 0; i <= nd; ++i)
        next[i] = nhd0[h[i] - kmin[h[i]]];
    for (i = nd + 1; i < m; ++i)
        next[i] = nhd0[m - rmin[h[i]]];
    next[m] = nhd0[m - rmin[h[m - 1]]];
    
    return (nd);
}
void MTKGalilGiancarloSearch(char *x, char *y, int *output) {
    
    int p = 0;
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    
    int i, j, k, ell, last, nd;
    int h[XSIZE], next[XSIZE], shift[XSIZE];
    char heavy;
    
    for (ell = 0; x[ell] == x[ell + 1]; ell++)
        ;
    if (ell == m - 1)
        /* Searching for a power of a single character */
        for (j = ell = 0; j < n; ++j)
            if (x[0] == y[j]) {
                ++ell;
                if (ell >= m)
                    output[p] = (j - m + 1);
                p++;
                // OUTPUT(j - m + 1);
            } else
                ell = 0;
            else {
                /* Preprocessing */
                nd = preGalilGiancarlo(x, m, h, next, shift);
               // nd = xx;
                /* Searching */
                i = j = heavy = 0;
                last = -1;
                while (j <= n - m) {
                    if (heavy && i == 0) {
                        k = last - j + 1;
                        while (x[0] == y[j + k])
                            k++;
                        if (k <= ell || x[ell + 1] != y[j + k]) {
                            i = 0;
                            j += (k + 1);
                            last = j - 1;
                        } else {
                            i = 1;
                            last = j + k;
                            j = last - (ell + 1);
                        }
                        heavy = 0;
                    } else {
                        while (i < m && last < j + h[i] && x[h[i]] == y[j + h[i]])
                            ++i;
                        if (i >= m || last >= j + h[i]) {
                            output[p] = j;
                            p++;
                            // OUTPUT(j);
                            i = m;
                        }
                        if (i > nd)
                            last = j + m - 1;
                        j += shift[i];
                        i = next[i];
                    }
                    heavy = (j > last ? 0 : 1);
                }
            }
}

@end

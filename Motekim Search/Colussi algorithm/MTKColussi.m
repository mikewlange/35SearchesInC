//
//  MTKColussi.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

/////////////////////////////
//+++++++++++++++++++++++++++
// Colussi algorithm
//+++++++++++++++++++++++++++
/////////////////////////////

//+++++++++++++++++++++++++++
// MAIN FEATURES
//+++++++++++++++++++++++++++
// refinement of the Knuth, Morris and Pratt algorithm;
// partitions the set of pattern positions into two disjoint subsets; the
// positions in the first set are scanned from left to right and when no mismatch
// occurs the positions of the second subset are scanned from right to left;
// preprocessing phase in O(m) time and space complexity;
// searching phase in O(n) time complexity;
// performs 3/2n text character comparisons in the worst case.

// Description
// The design of the Colussi algorithm follows a tight analysis of the Knuth,
// Morris and Pratt algorithm.
// http://www-igm.univ-mlv.fr/~lecroq/string/node10.html#SECTION00100 for more

#import "MTKColussi.h"
#import "includeme.h"
@implementation MTKColussi
#define XSIZE   20
#define ASIZE   256

int preColussi(char *x, int m, int h[], int next[], int shift[]) {
    
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

void COLUSSI(char *x, char *y, int *output) {
    
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    int p = 0;
    int i, j, last, nd, h[XSIZE], next[XSIZE], shift[XSIZE];
    
    /* Processing */
    nd = preColussi(x, m, h, next, shift);
    
    /* Searching */
    i = j = 0;
    last = -1;
    while (j <= n - m) {
        while (i < m && last < j + h[i] && x[h[i]] == y[j + h[i]])
        i++;
        if (i >= m || last >= j + h[i]) {
            // OUTPUT(j);
            output[p] = j;
            p++;
            i = m;
        }
        if (i > nd)
        last = j + m - 1;
        j += shift[i];
        i = next[i];
    }
}

@end

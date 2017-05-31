//
//  MTKApostolicoCrochemore.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKApostolicoCrochemore.h"
#import "includeme.h"
// Apostolico-Crochemore algorithm
/////////////////////////////
//+++++++++++++++++++++++++++
// Apostolico-Crochemore algorithm
//+++++++++++++++++++++++++++
/////////////////////////////

//+++++++++++++++++++++++++++
// MAIN FEATURES
//+++++++++++++++++++++++++++
// preprocessing phase in O(m) time and space complexity;
// searching phase in O(n) time complexity;
// performs 3/2n text character comparisons in the worst case.
// more: http://www-igm.univ-mlv.fr/~lecroq/string/node12.html#SECTION00120

@implementation MTKApostolicoCrochemore

#define ASIZE   256
void preKmp(char *x, int m, int kmpNext[]) {
    int i, j;
    
    i = 0;
    j = kmpNext[0] = -1;
    while (i < m) {
        while (j > -1 && x[i] != x[j])
            j = kmpNext[j];
        i++;
        j++;
        if (x[i] == x[j])
            kmpNext[i] = kmpNext[j];
        else
            kmpNext[i] = j;
    }
}

void ApostolicoCrochemoreSearch(char *x,int m, char *y, int n,int *output) {
    

    int q = 0;
    int i, j, k, ell, kmpNext[XSIZE];
    
    /* Preprocessing */
    preKmp(x, m, kmpNext);
    for (ell = 1; x[ell - 1] == x[ell]; ell++)
        ;
    if (ell == m)
        ell = 0;
    
    /* Searching */
    i = ell;
    j = k = 0;
    while (j <= n - m) {
        while (i < m && x[i] == y[i + j])
            ++i;
        if (i >= m) {
            while (k < ell && x[k] == y[j + k])
                ++k;
            if (k >= ell)
                // OUTPUT(j);
                output[q] = j;
            q++;
        }
        j += (i - kmpNext[i]);
        if (i == ell)
            k = MAX(0, k - 1);
        else if (kmpNext[i] <= ell) {
            k = MAX(0, kmpNext[i]);
            i = ell;
        } else {
            k = ell;
            i = kmpNext[i];
        }
    }
}

@end

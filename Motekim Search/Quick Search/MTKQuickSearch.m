//
//  MTKQuickSearch.m
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
//simplification of the Boyer-Moore algorithm;
//uses only the bad-character shift;
//easy to implement;
//preprocessing phase in O(m+sigma) time and O(sigma) space complexity;
//searching phase in O(mn) time complexity;
//very fast in practice for short patterns and large alphabets.



#import "MTKQuickSearch.h"
#import "includeme.h"
@implementation MTKQuickSearch
#define XSIZE   20
#define ASIZE   256
void preQsBcQS(char *x, int m, int qsBc[]) {
    int i;
    
    for (i = 0; i < ASIZE; ++i)
        qsBc[i] = m + 1;
    for (i = 0; i < m; ++i)
        qsBc[x[i]] = m - i;
}


void QSASearch(char *x,char *y, int *output) {
    
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    int p = 0;
    
    int j, qsBc[ASIZE];
    
    /* Preprocessing */
    preQsBcQS(x, m, qsBc);
    
    /* Searching */
    j = 0;
    while (j <= n - m) {
        if (memcmp(x, y + j, m) == 0)
            output[p] = (j);
        p++;
        j += qsBc[y[j + m]];               /* shift */
    }
}



@end

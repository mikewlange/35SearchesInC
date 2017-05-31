//
//  MTKMorrisPratt.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//
/////////////////////////////
//+++++++++++++++++++++++++++

// Morris-Pratt algorithm

//+++++++++++++++++++++++++++
/////////////////////////////

/////////////////////////////
//+++++++++++++++++++++++++++

// MAIN FEATURES
//performs the comparisons from left to right;
//preprocessing phase in O(m) space and time complexity;
//searching phase in O(n+m) time complexity (independent from the alphabet size);
//performs at most 2n-1 information gathered during the scan of the text;
//delay bounded by m.

//+++++++++++++++++++++++++++
/////////////////////////////

/////////////////////////////
//+++++++++++++++++++++++++++

// DESCRIPTIOn
// http://www-igm.univ-mlv.fr/~lecroq/string/node7.html#SECTION0070

//+++++++++++++++++++++++++++
/////////////////////////////


#import "MTKMorrisPratt.h"
#include "includeme.h"

@implementation MTKMorrisPratt

void preMp(char *x, int m, int mpNext[]) {
    int i, j;
    
    i = 0;
    j = mpNext[0] = -1;
    while (i < m) {
        while (j > -1 && x[i] != x[j])
        j = mpNext[j];
        mpNext[++i] = ++j;
    }
}


void MTKMorrisPrattSearch(char *x, int m, char *y, int n, int* output) {
    int inLoop;
    inLoop=0;
    int i, j, mpNext[n];
    
    /* Preprocessing */
    preMp(x, m, mpNext);
    
    /* Searching */
    i = j = 0;
    while (j < n) {
        while (i > -1 && x[i] != y[j])
        i = mpNext[i];
        i++;
        j++;
        if (i >= m) {
            output[inLoop]=(j-i);
            inLoop++;
            i = mpNext[i];
        }
    }
}


@end

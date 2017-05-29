//
//  MTKShiftAnd.m
//  Motekim Search
//
//  Created by Michael Lange on 5/29/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKShiftAnd.h"
#include "includeme.h"
#import "define.h"
@implementation MTKShiftAnd

void preSA(unsigned char *x, int m, unsigned int S[]) {
    unsigned int j, lim;
    int i;
    for (i = 0; i < SIGMA; ++i) S[i] = 0;
    for (i = 0, j = 1; i < m; ++i, j <<= 1) {
        S[x[i]] |= j;
    }
}

int ShiftAndsearch(unsigned char *x, int m, unsigned char *y, int n, int*output) {
    unsigned int lim, D;
    unsigned int S[SIGMA], F;
    int j, count;
    if (m > WORD) return search_large(x,m,y,n);
    int xx = 0;
    /* Preprocessing */
    preSA(x, m, S);
    F = 1<<(m-1);
    
    /* Searching */
    count = 0;
    for (D = 0, j = 0; j < n; ++j) {
        D = ((D<<1) | 1) & S[y[j]];
        if (D & F){
            output[xx] =(j - m + 1);
            xx++;
            OUTPUT(j - m + 1);
        }
    }
    return count;
}

/*
 * Shift And algorithm designed for large patterns
 * The present implementation searches for prefixes of the pattern of length 32.
 * When an occurrence is found the algorithm tests for the whole occurrence of the pattern
 */

int search_large(unsigned char *x, int m, unsigned char *y, int n) {
    unsigned int lim, D,k,h,p_len;
    unsigned int S[SIGMA], F;
    int j, count;
    
    p_len = m;
    m=32;
    
    /* Preprocessing */
    preSA(x, m, S);
    F = 1<<(m-1);
    
    /* Searching */
    count = 0;
    for (D = 0, j = 0; j < n; ++j) {
        D = ((D<<1)|1) & S[y[j]];
        if (D & F) {
            k = 0;
            h = j-m+1;
            while(k<p_len && x[k]==y[h+k]) k++;
            if (k==p_len) OUTPUT(j - m + 1);
        }
    } 
    return count;
} 



@end

//
//  MTKbmh-sbndm.m
//  Motekim Search
//
//  Created by Michael Lange on 5/29/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKbmh-sbndm.h"
#import "includeme.h"
@implementation MTKbmh_sbndm


#define XSIZE   20
#define ASIZE   256
int search(unsigned char *x, int m, unsigned char *y, int n) {
    int i, j,k,s, count, hbc[SIGMA], shift;
    unsigned int B[SIGMA], D;
    
    if (m>32) return search_large(x,m,y,n);
    
    /* Preprocessing */
    for (i=0;i<SIGMA;i++)
        hbc[i]=m;
    for (i=0;i<m;i++)
        hbc[x[i]]=m-i-1;
    for (i=0; i<SIGMA; i++)
        B[i] = 0;
    for (i=0; i<m; i++)
        B[x[m-i-1]] |= (unsigned int)1 << (i+WORD-m);
    for (i=0; i<m; i++)
        y[n+i]=x[i];
    D = B[x[m-1]]; j=1; shift=1;
    for (i=m-2; i>0; i--, j++) {
        if (D & (1<<(m-1))) shift = j;
        D = (D<<1) & B[x[i]];
    }
    
    /* Searching */
    count = 0;
    if ( !memcmp(x,y,m) ) OUTPUT(0);
    i = m;
    while(i < n) {
        while( (k=hbc[y[i]])!=0 ) i+=k;
        j=i; s=i-m+1;
        D = B[y[j]];
        while(D!=0) {
            j--;
            D = (D<<1) & B[y[j]];
        }
        if (j<s) {
            if (s<n && i<n) OUTPUT(s);
            i += shift;
        }
        else i = j+m;
    }
    return count;
}

/*
 * Horspool algorithm with BNDM test designed for large patterns
 * The present implementation searches for prefixes of the pattern of length 32.
 * When an occurrence is found the algorithm tests for the whole occurrence of the pattern
 */

int search_large(unsigned char *x, int m, unsigned char *y, int n) {
    int i, j,k,s, count, hbc[SIGMA], shift, p_len;
    unsigned int B[SIGMA], D;
    
    p_len = m;
    m = 32;
    int diff = p_len-m;
    
    /* Preprocessing */
    for (i=0;i<SIGMA;i++)
        hbc[i]=m;
    for (i=0;i<m;i++)
        hbc[x[i]]=m-i-1;
    for (i=0; i<SIGMA; i++)
        B[i] = 0;
    for (i=0; i<m; i++)
        B[x[m-i-1]] |= (unsigned int)1 << (i+WORD-m);
    for (i=0; i<m; i++)
        y[n+i]=x[i];
    D = B[x[m-1]]; j=1; shift=1;
    for (i=m-2; i>0; i--, j++) {
        if (D & (1<<(m-1))) shift = j;
        D = (D<<1) & B[x[i]];
    }
    
    /* Searching */
    count = 0;
    if ( !memcmp(x,y,m) ) OUTPUT(0);
    i = m;
    while(i+diff < n) {
        while( (k=hbc[y[i]])!=0 ) i+=k;
        j=i; s=i-m+1;
        D = B[y[j]];
        while(D!=0) {
            j--;
            D = (D<<1) & B[y[j]];
        }
        if (j<s) {
            if (s<n) {
                k = m;
                while(k<p_len && x[k]==y[s+k]) k++;
                if (k==p_len && i+diff<n) OUTPUT(s);
            }
            i += shift;
        }
        else i = j+m;
    }
    return count;
}



@end

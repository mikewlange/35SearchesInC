//
//  bmh-sbndm.m
//  Motekim Search
//
//  Created by Michael Lange on 5/29/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "bmh-sbndm.h"
#import "includeme.h"
@implementation bmh_sbndm


int searchsbndm( char *x, char *y, int *nout) {
    
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    int pp = 0;
    
    
    int j,i, last, first, hbc[SIGMA];
    unsigned int D, B[SIGMA], s;
    int mM1 = m-1;
    int mM2 = m-2;
    int count = 0, restore[XSIZE+1], shift;
    if (m>32) return search_large_new(x,y,nout);
    
    /* preprocessing */
    for (i=0; i<SIGMA; i++)  B[i] = 0;
    for (i=0; i<m; i++) B[x[m-i-1]] |= (unsigned int)1 << (i+WORD-m);
    for (i=0;i<SIGMA;i++)   hbc[i]=2*m;
    for (i=0;i<m;i++)     hbc[x[i]]=(2*m)-i-1;
    last = m;
    s = (unsigned int)(~0) << (WORD-m);
    s = (unsigned int)(~0);
    for (i=m-1; i>=0; i--) {
        s &= B[x[i]];
        if (s & ((unsigned int)1<<(WORD-1))) {
            if (i > 0)  last = i;
        }
        restore[i] = last;
        s <<= 1;
    }
    shift = restore[0];
    
    for (i=0; i<m; i++)
        {
            y[n+i]=x[i];
        }
    
    /* Searching */
    if ( !memcmp(x,y,m) ) count++;
    i = m;
    while (1) {
        while ((D = B[y[i]]) == 0) i += hbc[y[i+m]];
        j = i-1; first = i-m+1;
        while (1) {
            D = (D << 1) & B[y[j]];
            if (!((j-first) && D)) break;
            j--;
        }
        if (D != 0) {
            if (i >= n) return count;
            count++;
            i += shift;
        }
        else {
            i = j+m;
        }
    }
}

/*
 * Simplified Backward Nondeterministic DAWG Matching with Horspool shift designed for large patterns
 * The present implementation searches for prefixes of the pattern of length 32.
 * When an occurrence is found the algorithm tests for the whole occurrence of the pattern
 */

int search_large_new( char *x,  char *y, int* outs) {
    
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    int pp = 0;
    
    int j,i, last, first, p_len, k, hbc[SIGMA];
    unsigned int D, B[SIGMA], s;
    int mM1 = m-1;
    int mM2 = m-2;
    int count = 0, restore[XSIZE+1], shift;
    
    p_len = m;
    m = 32;
    int diff = p_len-m;
    
    /* preprocessing */
    for (i=0; i<SIGMA; i++)  B[i] = 0;
    for (i=0; i<m; i++) B[x[m-i-1]] |= (unsigned int)1 << (i+WORD-m);
    for (i=0;i<SIGMA;i++)   hbc[i]=2*m;
    for (i=0;i<m;i++)     hbc[x[i]]=(2*m)-i-1;
    last = m;
    s = (unsigned int)(~0) << (WORD-m);
    s = (unsigned int)(~0);
    for (i=m-1; i>=0; i--) {
        s &= B[x[i]];
        if (s & ((unsigned int)1<<(WORD-1))) {
            if (i > 0)  last = i;
        }
        restore[i] = last;
        s <<= 1;
    }
    shift = restore[0];
    
    for (i=0; i<m; i++) y[n+i]=x[i];
    
    /* Searching */
    if ( !memcmp(x,y,p_len) ) OUTPUT(0);
    i = m;
    while (1) {
        while ((D = B[y[i]]) == 0) i += hbc[y[i+m]];
        j = i-1; first = i-m+1;
        while (1) {
            D = (D << 1) & B[y[j]];
            if (!((j-first) && D)) break;
            j--;
        }
        if (D != 0) {
            if (i+diff >= n) return count;
            k=m;
            while(k<p_len && x[k]==y[first+k]) k++;
            if (k==p_len){ outs[pp] = first; pp++; OUTPUT(first);
            i += shift;
            }
        }
        else {
            i = j+m;
        }
    }
}


//void searchBMHSBNDM( char *x, char *y, int* outp) {
//    
//    int m = (int)strlen(x);
//    int n = (int)strlen(y);
//    int pp = 0;
//    int i, j,k,s, count, hbc[SIGMA], shift;
//    unsigned int B[SIGMA], D;
//    
//    if (m>32) {search_large_bmh(x,m,y,n,outp);}
//    
//    /* Preprocessing */
//    for (i=0;i<SIGMA;i++)
//        hbc[i]=m;
//    for (i=0;i<m;i++)
//        hbc[x[i]]=m-i-1;
//    for (i=0; i<SIGMA; i++)
//        B[i] = 0;
//    for (i=0; i<m; i++)
//        B[x[m-i-1]] |= (unsigned int)1 << (i+WORD-m);
//    for (i=0; i<m; i++)
//        y[n-i]=x[i];
//    D = B[x[m-1]]; j=1; shift=1;
//    for (i=m-2; i>0; i--, j++) {
//        if (D & (1<<(m-1))) shift = j;
//        D = (D<<1) & B[x[i]];
//    }
//    
//    /* Searching */
//    count = 0;
//    if ( !memcmp(x,y,m) ) OUTPUT(0);
//    i = m;
//    while(i < n) {
//        while( (k=hbc[y[i]])!=0 ) i+=k;
//        j=i; s=i-m+1;
//        D = B[y[j]];
//        while(D!=0) {
//            j--;
//            D = (D<<1) & B[y[j]];
//        }
//        if (j<s) {
//            if (s<n && i<n){
//                outp[pp] = s;
//                pp++;
//              //  OUTPUT(s);
//            i += shift;
//            }
//        }
//        else i = j+m;
//    }
//}
//
///*
// * Horspool algorithm with BNDM test designed for large patterns
// * The present implementation searches for prefixes of the pattern of length 32.
// * When an occurrence is found the algorithm tests for the whole occurrence of the pattern
// */
//
//void search_large_bmh( char *x, int m,  char *y, int n, int* outp) {
//    int i, j,k,s, count, hbc[SIGMA], shift, p_len;
//    unsigned int B[SIGMA], D;
//    int pp = 0;
//    p_len = m;
//    m = 32;
//    int diff = p_len-m;
//    
//    /* Preprocessing */
//    for (i=0;i<SIGMA;i++)
//        hbc[i]=m;
//    for (i=0;i<m;i++)
//        hbc[x[i]]=m-i-1;
//    for (i=0; i<SIGMA; i++)
//        B[i] = 0;
//    for (i=0; i<m; i++)
//        B[x[m-i-1]] |= (unsigned int)1 << (i+WORD-m);
//    for (i=0; i<m; i++)
//        y[n+i]=x[i];
//    D = B[x[m-1]]; j=1; shift=1;
//    for (i=m-2; i>0; i--, j++) {
//        if (D & (1<<(m-1))) shift = j;
//        D = (D<<1) & B[x[i]];
//    }
//    
//    /* Searching */
//    count = 0;
//    if ( !memcmp(x,y,m) ) OUTPUT(0);
//    i = m;
//    while(i+diff < n) {
//        while( (k=hbc[y[i]])!=0 ) i+=k;
//        j=i; s=i-m+1;
//        D = B[y[j]];
//        while(D!=0) {
//            j--;
//            D = (D<<1) & B[y[j]];
//        }
//        if (j<s) {
//            if (s<n) {
//                k = m;
//                while(k<p_len && x[k]==y[s+k]) k++;
//                if (k==p_len && i+diff<n)
//                    {
//                    outp[pp] = s;
//                    pp++;
//                    }
//            }
//            i += shift;
//        }
//        else i = j+m;
//    }
//}
@end

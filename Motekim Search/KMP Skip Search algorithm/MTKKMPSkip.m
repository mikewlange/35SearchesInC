//
//  MTKKMPSkip.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//
/////////////////////////////
//+++++++++++++++++++++++++++

// KMP Skip Search algorithm

//+++++++++++++++++++++++++++
/////////////////////////////

/////////////////////////////
//+++++++++++++++++++++++++++

//improvement of the Skip Search algorithm;
//uses buckets of positions for each character of the alphabet;
//preprocessing phase in O(m+sigma) time and space complexity;
//searching phase in O(n) time complexity.
//http://www-igm.univ-mlv.fr/~lecroq/string/node32.html#SECTION00320

//+++++++++++++++++++++++++++
/////////////////////////////
#import "MTKKMPSkip.h"
#import "includeme.h"
@implementation MTKKMPSkip



#define ASIZE   256
void skpreMp(char *x, int m, int mpNext[]) {
    int i, j;
    
    i = 0;
    j = mpNext[0] = -1;
    while (i < m) {
        while (j > -1 && x[i] != x[j])
            j = mpNext[j];
        mpNext[++i] = ++j;
    }
}

void skpreKmp(char *x, int m, int kmpNext[]) {
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

int skattempt(char *y, char *x, int m, int start, int wall) {
    int k;
    
    k = wall - start;
    while (k < m && x[k] == y[k + start])
        ++k;
    return(k);
}

void KMPSKIP(char *x,size_t m, char *y,size_t n, int* output) {
    
    int i, j, k, kmpStart, per, start, wall;
    int kmpNext[XSIZE], list[XSIZE], mpNext[XSIZE],
    z[ASIZE];
    int innerLoop = 0;
    /* Preprocessing */
    skpreMp(x, m, mpNext);
    skpreKmp(x, m, kmpNext);
    memset(z, -1, ASIZE*sizeof(int));
    memset(list, -1, m*sizeof(int));
    z[x[0]] = 0;
    for (i = 1; i < m; ++i) {
        list[i] = z[x[i]];
        z[x[i]] = i;
    }
    
    /* Searching */
    wall = 0;
    per = m - kmpNext[m];
    i = j = -1;
    do {
        j += m;
    } while (j < n && z[y[j]] < 0);
    if (j >= n)
        return;
    i = z[y[j]];
    start = j - i;
    while (start <= n - m) {
        if (start > wall)
            wall = start;
        k = skattempt(y, x, m, start, wall);
        wall = start + k;
        if (k == m) {
            output[innerLoop]=start;
            innerLoop++;
           // OUTPUT(start);
            i -= per;
        }
        else
            i = list[i];
        if (i < 0) {
            do {
                j += m;
            } while (j < n && z[y[j]] < 0);
            if (j >= n)
                return;
            i = z[y[j]];
        }
        kmpStart = start + k - kmpNext[k];
        k = kmpNext[k];
        start = j - i;
        while (start < kmpStart ||
               (kmpStart < start && start < wall)) {
            if (start < kmpStart) {
                i = list[i];
                if (i < 0) {
                    do {
                        j += m;
                    } while (j < n && z[y[j]] < 0);
                    if (j >= n)
                        return;
                    i = z[y[j]];
                }
                start = j - i;
            }
            else {
                kmpStart += (k - mpNext[k]);
                k = mpNext[k];
            }
        }
    }
}

@end

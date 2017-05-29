//
//  MTKTwoWay.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//
/////////////////////////////
//+++++++++++++++++++++++++++
// Two Way algorithm -
//+++++++++++++++++++++++++++
/////////////////////////////
//Two Way algorithm
//requires an ordered alphabet;
//preprocessing phase in O(m) time and constant space complexity;
//constant space complexity for the preprocessing phase;
//searching phase in O(n) time;
//performs 2n-m text character comparisons in the worst case.

#import "MTKTwoWay.h"
#import "includeme.h"

#define ASIZE   256
@implementation MTKTwoWay
/* Computing of the maximal suffix for <= */
int maxSuf(char *x, int m, int *p) {
    int ms, j, k;
    char a, b;
    
    ms = -1;
    j = 0;
    k = *p = 1;
    while (j + k < m) {
        a = x[j + k];
        b = x[ms + k];
        if (a < b) {
            j += k;
            k = 1;
            *p = j - ms;
        }
        else
            if (a == b)
                if (k != *p)
                    ++k;
                else {
                    j += *p;
                    k = 1;
                }
                else { /* a > b */
                    ms = j;
                    j = ms + 1;
                    k = *p = 1;
                }
    }
    return(ms);
}

/* Computing of the maximal suffix for >= */
int maxSufTilde(char *x, int m, int *p) {
    int ms, j, k;
    char a, b;
    
    ms = -1;
    j = 0;
    k = *p = 1;
    while (j + k < m) {
        a = x[j + k];
        b = x[ms + k];
        if (a > b) {
            j += k;
            k = 1;
            *p = j - ms;
        }
        else
            if (a == b)
                if (k != *p)
                    ++k;
                else {
                    j += *p;
                    k = 1;
                }
                else { /* a < b */
                    ms = j;
                    j = ms + 1;
                    k = *p = 1;
                }
    }
    return(ms);
}


/* Two Way string matching algorithm. */
void TW(char *x, char *y, int *output) {
    
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    int insideLoop = 0;
    
    int i, j, ell, memory, p, per, q;
    
    /* Preprocessing */
    i = maxSuf(x, m, &p);
    j = maxSufTilde(x, m, &q);
    if (i > j) {
        ell = i;
        per = p;
    }
    else {
        ell = j;
        per = q;
    }
    
    /* Searching */
    if (memcmp(x, x + per, ell + 1) == 0) {
        j = 0;
        memory = -1;
        while (j <= n - m) {
            i = MAX(ell, memory) + 1;
            while (i < m && x[i] == y[i + j])
                ++i;
            if (i >= m) {
                i = ell;
                while (i > memory && x[i] == y[i + j])
                    --i;
                if (i <= memory){
                    output[insideLoop]=j;
                    insideLoop++;
                    //  OUTPUT(j);
                    j += per;
                    memory = m - per - 1;
                }
            }
            else {
                j += (i - ell);
                memory = -1;
            }
        }
    }
    else {
        per = MAX(ell + 1, m - ell - 1) + 1;
        j = 0;
        while (j <= n - m) {
            i = ell + 1;
            while (i < m && x[i] == y[i + j])
                ++i;
            if (i >= m) {
                i = ell;
                while (i >= 0 && x[i] == y[i + j])
                    --i;
                if (i < 0){
                    output[insideLoop]=j;
                    insideLoop++;
                    // OUTPUT(j);
                    j += per;}
            }
            else
                j += (i - ell);
        }
    }
}
@end

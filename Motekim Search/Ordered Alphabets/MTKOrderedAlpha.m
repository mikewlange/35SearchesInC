//
//  MTKOrderedAlpha.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

/////////////////////////////
//+++++++++++++++++++++++++++
// String Matching on Ordered Alphabets algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//String Matching on Ordered Alphabets algorithm
//no preprocessing phase;
//requires an ordered alphabet;
//constant extra space complexity;
//searching phase in O(n) time;
//performs 6n+5 text character comparisons in the worst case.
//http://www-igm.univ-mlv.fr/~lecroq/string/node27.html#SECTION00270

#import "MTKOrderedAlpha.h"
#import "includeme.h"
@implementation MTKOrderedAlpha
/* Compute the next maximal suffix. */
void nextMaximalSuffix(char *x, int m,
                       int *i, int *j, int *k, int *p) {
    char a, b;
    
    while (*j + *k < m) {
        a = x[*i + *k];
        b = x[*j + *k];
        if (a == b)
            if (*k == *p) {
                (*j) += *p;
                *k = 1;
            }
            else
                ++(*k);
            else
                if (a > b) {
                    (*j) += *k;
                    *k = 1;
                    *p = *j - *i;
                }
                else {
                    *i = *j;
                    ++(*j);
                    *k = *p = 1;
                }
    }
}


/* String matching on ordered alphabets algorithm. */
void SMOASearch(char *x, int m,char *y, int n, int*output) {
    

    int internalLoop = 0;
    
    int i, ip, j, jp, k, p;
    
    /* Searching */
    ip = -1;
    i = j = jp = 0;
    k = p = 1;
    while (j <= n - m) {
        while (i + j < n && i < m && x[i] == y[i + j])
            ++i;
        if (i == 0) {
            ++j;
            ip = -1;
            jp = 0;
            k = p = 1;
        }
        else {
            if (i >= m)
                output[internalLoop] = j;
            internalLoop++;
            nextMaximalSuffix(y + j, i+1, &ip, &jp, &k, &p);
            if (ip < 0 ||
                (ip < p &&
                 memcmp(y + j, y + j + p, ip + 1) == 0)) {
                    j += p;
                    i -= p;
                    if (i < 0)
                        i = 0;
                    if (jp - ip > p)
                        jp -= p;
                    else {
                        ip = -1;
                        jp = 0;
                        k = p = 1;
                    }
                }
            else {
                j += (MAX(ip + 1,
                          MIN(i - ip - 1, jp + 1)) + 1);
                i = jp = 0;
                ip = -1;
                k = p = 1;
            }
        }
    }
}
@end

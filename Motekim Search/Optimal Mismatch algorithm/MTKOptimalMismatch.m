//
//  MTKOptimalMismatch.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

/////////////////////////////
//+++++++++++++++++++++++++++
//Optimal Mismatch algorithm
//+++++++++++++++++++++++++++
/////////////////////////////

//variant of the Quick Search algorithm;
//requires the frequencies of the characters;
//preprocessing phase in O(m2+sigma) time and O(m+sigma) space complexity;
//searching phase in O(mn) time complexity.
//http://www-igm.univ-mlv.fr/~lecroq/string/node28.html#SECTION00280
#import "MTKOptimalMismatch.h"
#import "includeme.h"
@implementation MTKOptimalMismatch


#define ASIZE   256

typedef struct patternScanOrder {
    int loc;
    char c;
} pattern;

int freq[ASIZE];

void preQsBc(char *x, int m, int qsBc[]) {
    int i;
    
    for (i = 0; i < ASIZE; ++i)
        qsBc[i] = m + 1;
    for (i = 0; i < m; ++i)
        qsBc[x[i]] = m - i;
}

/* Construct an ordered pattern from a string. */
void orderPattern(char *x, int m, int (*pcmp)(),
                  pattern *pat) {
    int i;
    
    for (i = 0; i <= m; ++i) {
        pat[i].loc = i;
        pat[i].c = x[i];
    }
    qsort(pat, m, sizeof(pattern), pcmp);
}


/* Optimal Mismatch pattern comparison function. */
int optimalPcmp(pattern *pat1, pattern *pat2) {
    float fx;
    
    fx = freq[pat1->c] - freq[pat2->c];
    return(fx ? (fx > 0 ? 1 : -1) :
           (pat2->loc - pat1->loc));
}


/* Find the next leftward matching shift for
 the first ploc pattern elements after a
 current shift or lshift. */
int matchShift(char *x, int m, int ploc,
               int lshift, pattern *pat) {
    int i, j;
    
    for (; lshift < m; ++lshift) {
        i = ploc;
        while (--i >= 0) {
            if ((j = (pat[i].loc - lshift)) < 0)
                continue;
            if (pat[i].c != x[j])
                break;
        }
        if (i < 0)
            break;
    }
    return(lshift);
}


/* Constructs the good-suffix shift table
 from an ordered string. */
void preAdaptedGs(char *x, int m, int adaptedGs[],
                  pattern *pat) {
    int lshift, i, ploc;
    
    adaptedGs[0] = lshift = 1;
    for (ploc = 1; ploc <= m; ++ploc) {
        lshift = matchShift(x, m, ploc, lshift, pat);
        adaptedGs[ploc] = lshift;
    }
    for (ploc = 0; ploc <= m; ++ploc) {
        lshift = adaptedGs[ploc];
        while (lshift < m) {
            i = pat[ploc].loc - lshift;
            if (i < 0 || pat[ploc].c != x[i])
                break;
            ++lshift;
            lshift = matchShift(x, m, ploc, lshift, pat);
        }
        adaptedGs[ploc] = lshift;
    }
}


/* Optimal Mismatch string matching algorithm. */
void OM(char *x,char *y, int*output) {
    
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    int insideLoop = 0;
    
    int i, j, adaptedGs[XSIZE], qsBc[ASIZE];
    pattern pat[XSIZE];
    
    /* Preprocessing */
    orderPattern(x, m, optimalPcmp, pat);
    preQsBc(x, m, qsBc);
    preAdaptedGs(x, m, adaptedGs, pat);
    
    /* Searching */
    j = 0;
    while (j <= n - m) {
        i = 0;
        while (i < m && pat[i].c == y[j + pat[i].loc])
            ++i;
        if (i >= m){
            output[insideLoop]=j;
        insideLoop++;
        j += MAX(adaptedGs[i],qsBc[y[j + m]]);
        }
    }
}

@end

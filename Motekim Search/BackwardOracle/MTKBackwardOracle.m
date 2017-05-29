//
//  MTKBackwardOracle.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKBackwardOracle.h"
#import "includeme.h"

@implementation MTKBackwardOracle


#define FALSE      0
#define TRUE       1

#define XSIZE   20
#define ASIZE   256

int BOgetTransition(char *x, int p, List L[], char c) {
    List cell;
    
    if (p > 0 && x[p - 1] == c)
        return(p - 1);
    else {
        cell = L[p];
        while (cell != NULL)
            if (x[cell->element] == c)
                return(cell->element);
            else
                cell = cell->next;
        return(UNDEFINED);
    }
}


void BOsetTransition(int p, int q, List L[]) {
    List cell;
    
    cell = (List)malloc(sizeof(struct _cell));
    if (cell == NULL)
       // error("BOM/setTransition");
    cell->element = q;
    cell->next = L[p];
    L[p] = cell;
}


void oracle(char *x, int m, char T[], List L[]) {
    int i, p, q = 0;
    int S[XSIZE + 1];
    char c;
    
    S[m] = m + 1;
    for (i = m; i > 0; --i) {
        c = x[i - 1];
        p = S[i];
        while (p <= m &&
               (q = BOgetTransition(x, p, L, c)) ==
               UNDEFINED) {
            BOsetTransition(p, i - 1, L);
            p = S[p];
        }
        S[i - 1] = (p == m + 1 ? m : q);
    }
    p = 0;
    while (p <= m) {
        T[p] = TRUE;
        p = S[p];
    }
}


void BOM(char *x,char *y, int*output) {
    
    int m = (int)strlen(x);
    int n = (int)strlen(y);
    
    char T[XSIZE + 1];
    List L[XSIZE + 1];
    int i, j, p, period = 0, q, shift;
    int pp = 0;
    /* Preprocessing */
    memset(L, 0, (m + 1)*sizeof(List));
    memset(T, FALSE, (m + 1)*sizeof(char));
    oracle(x, m, T, L);
    
    /* Searching */
    j = 0;
    while (j <= n - m) {
        i = m - 1;
        p = m;
        shift = m;
        while (i + j >= 0 &&
               (q = BOgetTransition(x, p, L, y[i + j])) !=
               UNDEFINED) {
            p = q;
            if (T[p] == TRUE) {
                period = shift;
                shift = i;
            }
            --i;
        }
        if (i < 0) {
           // OUTPUT(j);
            output[pp]=j;
            pp++;
            shift = period;
        }
        j += shift;
    }
}


@end

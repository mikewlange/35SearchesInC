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

int getTransitionBO(unsigned char *x, int p, List L[], unsigned char c) {
    List cell;
    if (p > 0 && x[p - 1] == c) return(p - 1);
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

void setTransitionBO(int p, int q, List L[]) {
    List cell;
    cell = (List)malloc(sizeof(struct _cell));
    if (cell == NULL)
       // error("BOM/setTransition");
    cell->element = q;
    cell->next = L[p];
    L[p] = cell;
}

void oracle(unsigned char *x, int m, char T[], List L[]) {
    int i, p, q = 0;
    int S[XSIZE + 1];
    char c;
    S[m] = m + 1;
    for (i = m; i > 0; --i) {
        c = x[i - 1];
        p = S[i];
        while (p <= m &&
               (q = getTransitionBO(x, p, L, c)) ==
               UNDEFINED) {
            setTransitionBO(p, i - 1, L);
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


int boma(unsigned char *x, int m, unsigned char *y, int n, int*rcOut) {
    char T[XSIZE + 1];
    List L[XSIZE + 1];
    int i, j, p, period = 0, q, shift, count;
    
    /* Preprocessing */
    memset(L, 0, (m + 1)*sizeof(List));
    memset(T, FALSE, (m + 1)*sizeof(char));
    oracle(x, m, T, L);
    
    /* Searching */
    count = 0;
    j = 0;
    while (j <= n - m) {
        i = m - 1;
        p = m;
        shift = m;
        while (i + j >= 0 && (q = getTransitionBO(x, p, L, y[i + j])) != UNDEFINED) {
            p = q;
            if (T[p] == TRUE) {
                period = shift;
                shift = i;
            }
            --i;
        }
        if (i < 0) {
            outp(j);
            shift = period;
        }
        j += shift;
    }
    for (i=0; i<=m; i++) free(L[i]);
    return count;
}



//int BOgetTransition(char *x, int p, List L[], char c) {
//    List cell;
//    
//    if (p > 0 && x[p - 1] == c)
//        return(p - 1);
//    else {
//        cell = L[p];
//        while (cell != NULL)
//            if (x[cell->element] == c)
//                return(cell->element);
//            else
//                cell = cell->next;
//        return(UNDEFINED);
//    }
//}
//
//
//void BOsetTransition(int p, int q, List L[]) {
//    List cell;
//    
//    cell = (List)malloc(sizeof(struct _cell));
//    if (cell == NULL)
//       // error("BOM/setTransition");
//    cell->element = q;
//    cell->next = L[p];
//    L[p] = cell;
//}
//
//
//void oracle(char *x, int m, char T[], List L[]) {
//    int i, p, q = 0;
//    int S[XSIZE + 1];
//    char c;
//    
//    S[m] = m + 1;
//    for (i = m; i > 0; --i) {
//        c = x[i - 1];
//        p = S[i];
//        while (p <= m &&
//               (q = BOgetTransition(x, p, L, c)) ==
//               UNDEFINED) {
//            BOsetTransition(p, i - 1, L);
//            p = S[p];
//        }
//        S[i - 1] = (p == m + 1 ? m : q);
//    }
//    p = 0;
//    while (p <= m) {
//        T[p] = TRUE;
//        p = S[p];
//    }
//}
//
//
//void boma(char *x, int m, char *y, int n , int*rcOut) {
//    
//    
//    char T[XSIZE + 1];
//    List L[XSIZE + 1];
//    int i, j, p, period = 0, q, shift;
//    int pp = 0;
//    /* Preprocessing */
//    memset(L, 0, (m + 1)*sizeof(List));
//    memset(T, FALSE, (m + 1)*sizeof(char));
//    oracle(x, m, T, L);
//    
//    /* Searching */
//    j = 0;
//    while (j <= n - m) {
//        i = m - 1;
//        p = m;
//        shift = m;
//        while (i + j >= 0 &&
//               (q = BOgetTransition(x, p, L, y[i + j])) !=
//               UNDEFINED) {
//            p = q;
//            if (T[p] == TRUE) {
//                period = shift;
//                shift = i;
//            }
//            --i;
//        }
//        if (i < 0) {
//           outp(j);
//            rcOut[pp]=j;
//            pp++;
//            shift = period;
//        }
//        j += shift;
//    }
//}


@end

//
//  MTKSimonAlgo.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

/////////////////////////////
//+++++++++++++++++++++++++++

//SIMON

//+++++++++++++++++++++++++++
/////////////////////////////

//economical implementation of  A(x) the minimal Deterministic Finite Automaton recognizing Sigma*x;
//preprocessing phase in O(m) time and space complexity;
//searching phase in O(m+n) time complexity (independent from the alphabet size);
//at most 2n-1 text character comparisons during the searching phase;
//delay bounded by min{1 + log2m, sigma}.

/// DESCRIPTION http://www-igm.univ-mlv.fr/~lecroq/string/node9.html#SECTION0090


#import "MTKSimonAlgo.h"
#import "includeme.h"
@implementation MTKSimonAlgo

int getTransitionSIMON(char *x, int m, int p, List L[],
                  char c) {
    List cell;
    
    if (p < m - 1 && x[p + 1] == c)
    return(p + 1);
    else if (p > -1) {
        cell = L[p];
        while (cell != NULL)
        if (x[cell->element] == c)
        return(cell->element);
        else
        cell = cell->next;
        return(-1);
    }
    else
    return(-1);
}


void setTransitionSIMON(int p, int q, List L[]) {
    List cell;
    
    cell = (List)malloc(sizeof(struct _cell));
    if (cell == NULL)
    //error("SIMON/setTransition");
    cell->element = q;
    cell->next = L[p];
    L[p] = cell;
}


int preSimon(char *x, int m, List L[]) {
    int i, k, ell;
    List cell;
    
    memset(L, 0, (m - 2)*sizeof(List));
    ell = -1;
    for (i = 1; i < m; ++i) {
        k = ell;
        cell = (ell == -1 ? NULL : L[k]);
        ell = -1;
        if (x[i] == x[k + 1])
        ell = k + 1;
        else
        setTransitionSIMON(i - 1, k + 1, L);
        while (cell != NULL) {
            k = cell->element;
            if (x[i] == x[k])
            ell = k;
            else
            setTransitionSIMON(i - 1, k, L);
            cell = cell->next;
        }
    }
    return(ell);
}


void SIMON(char *x, int m, char *y, int n, int* output) {

    int j, ell, state;
    List L[m];
    int q  = 0;
    /* Preprocessing */
    ell = preSimon(x, m, L);
    
    /* Searching */
    for (state = -1, j = 0; j < n; ++j) {
        state = getTransitionSIMON(x, m, state, L, y[j]);
        if (state >= m - 1) {
            output[q]= (j - m + 1);
             printf("SIMON Found pattern at index %d \n",(j - m + 1));
            q++;
            state = ell;
        }
    }
}



@end

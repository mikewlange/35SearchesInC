//
//  MTKSmith.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKSmith.h"
#import "includeme.h"
@implementation MTKSmith
#define XSIZE   20
#define ASIZE   256
void SMITH(char *x, int m, char *y, int n, int*output) {
    int j, bmBc[ASIZE], qsBc[ASIZE];
    
    /* Preprocessing */
    smpreBmBc(x, m, bmBc);
    smpreQsBc(x, m, qsBc);
    int p = 0;
    /* Searching */
    j = 0;
    while (j<= n - m) {
        if (memcmp(x, y + j, m) == 0){
        printf ("\n SMITH Pattern found at index %d", j);
            output[p]=j;
            p++;
            j += MAX(bmBc[y[j + m - 1]], qsBc[y[j + m]]);
        }
    }
}

void smpreBmBc(char *x, int m, int bmBc[]) {
    int i;
    for (i = 0; i < ASIZE; ++i)
        bmBc[i] = m;
    for (i = 0; i < m - 1; ++i)
        bmBc[x[i]] = m - i - 1;
}



void smpreQsBc(char *x, int m, int qsBc[]) {
    int i;
    
    for (i = 0; i < ASIZE; ++i)
        qsBc[i] = m + 1;
    for (i = 0; i < m; ++i)
        qsBc[x[i]] = m - i;
}


@end

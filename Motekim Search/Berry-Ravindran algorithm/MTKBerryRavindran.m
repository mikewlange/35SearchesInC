//
//  MTKBerryRavindran.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//
/////////////////////////////
//+++++++++++++++++++++++++++
// Berry-Ravindran algorithm
//+++++++++++++++++++++++++++
/////////////////////////////
//hybrid of the Quick Search and Zhu and Takaoka algorithms;
//preprocessing phase in O(m+sigma2) space and time complexity;
//searching phase in O(mn) time complexity.
#import "MTKBerryRavindran.h"
#import "includeme.h"


#define SIGMA   256
@implementation MTKBerryRavindran
void preBrBc(unsigned char *x, int m, int brBc[SIGMA][SIGMA]) {
    int a, b, i;
    for (a = 0; a < SIGMA; ++a)
        for (b = 0; b < SIGMA; ++b)
            brBc[a][b] = m + 2;
    for (a = 0; a < SIGMA; ++a)
        brBc[a][x[0]] = m + 1;
    for (i = 0; i < m - 1; ++i)
        brBc[x[i]][x[i + 1]] = m - i;
    for (a = 0; a < SIGMA; ++a)
        brBc[x[m - 1]][a] = 1;
}


void BR(unsigned char *x, int m, unsigned char *y, int n) {
    int j, brBc[SIGMA][SIGMA];
    int i;
    int count;
    
    /* Preprocessing */
    preBrBc(x, m, brBc);
    count =0;
    
    /* Searching */
    y[n + 1] = 0;
    j = 0;
    while (j <= n - m) {
        for (i=0; i<m && x[i]==y[j+i]; i++);
        if (i>=m) count++;
        j += brBc[y[j + m]][y[j + m + 1]];
    } 
   // return count;
} 


@end

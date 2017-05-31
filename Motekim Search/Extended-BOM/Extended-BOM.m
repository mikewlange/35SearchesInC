//
//  Extended-BOM.m
//  Motekim Search
//
//  Created by Michael Lange on 5/30/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "Extended-BOM.h"
#import "includeme.h"
@implementation Extended_BOM

int searchEBOM( char *x, int m,  char *y, int n) {
    int S[XSIZE], FT[SIGMA][SIGMA];
    int *trans[XSIZE];
    int i, j, p, q = 0;
    int iMinus1, mMinus1, count;
    unsigned char c;
    count = 0;
    
    /* Preprocessing */
    for (i=0; i<=m+1; i++) trans[i] = (int *)malloc (sizeof(int)*(SIGMA));
    for (i=0; i<=m+1; i++) for (j=0; j<SIGMA; j++) trans[i][j]=UNDEFINED;
    S[m] = m + 1;
    for (i = m; i > 0; --i) {
        iMinus1 = i - 1;
        c = x[iMinus1];
        trans[i][c] = iMinus1;
        p = S[i];
        while (p <= m && (q = trans[p][c]) ==  UNDEFINED) {
            trans[p][c] = iMinus1;
            p = S[p];
        }
        S[iMinus1] = (p == m + 1 ? m : q);
    }
    
    /* Construct the First transition table */
    for (i=0; i<SIGMA; i++) {
        q = trans[m][i];
        for (j=0; j<SIGMA; j++)
            if (q>=0) {
                if ((p=trans[q][j])>=0) FT[i][j] = p;
                else FT[i][j]=m+m+1;
            }
            else FT[i][j] = m+m+1;
    }
    q = trans[m][x[m-1]];
    for (i=0; i<SIGMA; i++) FT[i][x[m-1]] = q;
    for (i=0; i<SIGMA; i++) if (FT[x[0]][i]>m) FT[x[0]][i]-=1;
    
    /* Searching */
    for (i=0; i<m; i++) y[n+i]=x[i];
    if ( !memcmp(x,y,m) ) count++;
    j=m;
    mMinus1 = m-1;
    while (j<n) {
        while ( (p=FT[y[j+1]][y[j]])>m ) j+=p-m;
        i = j-1;
        while ( (p = trans[p][y[i]]) != UNDEFINED ) i--;
        if (i < j-mMinus1 && j<n) {
            count++;
            i++;
        }
        j = i + m;
    } 
    
    for (i=0; i<=m+1; i++) free(trans[i]); 
    return count; 
} 



@end

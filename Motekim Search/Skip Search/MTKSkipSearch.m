//
//  MTKSkipSearch.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKSkipSearch.h"
#import "includeme.h"
#import "util.h"
@implementation MTKSkipSearch

#define ASIZE   256//

void SKIPSearch(char *x,int m, char *y,int n, int* output) {
    unsigned long j;    int i;
    List ptr, z[ASIZE];
    int loopCount=0;
    /* Preprocessing */
    memset(z, 0, ASIZE*sizeof(List));
    for (i = 0; i < m; ++i) {
        ptr = (List)malloc(sizeof(struct _cell));
        if (ptr == NULL)
          //  error("SKIP");
        ptr->element = i;
        ptr->next = z[x[i]];
        z[x[i]] = ptr;
    }
    
    /* Searching */
    for (j = m - 1; j < n; j += m)
        for (ptr = z[y[j]]; ptr != NULL; ptr = ptr->next)
            if (memcmp(x, y + j - ptr->element, m) == 0){
                output[loopCount]=j - ptr->element;
                loopCount++;
               // OUTPUT(j - ptr->element);
            }
}



@end

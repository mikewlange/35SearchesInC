//
//  bruteforce.m
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import "MTKbruteforce.h"
#include "includeme.h"

@implementation MTKbruteforce

// I think this is about a fast as real brute force can be. What could I change? 

#define EOS '\0'
void BF(char *x, char *y, char *n) {
    int inLoop = 0;
    char *yb;
    int m = (int)strlen(x);
    /* Searching */
    for (yb = y; *y != EOS; ++y)
    if (memcmp(x, y, m) == 0) {
        n[inLoop] = y - yb;
          printf("Found pattern at index %ld \n", y - yb);
        inLoop++;
        break;
    }

}


@end

//
//  bruteforce.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTKbruteforce : NSObject



@end
void BF(char *x, char *y, char *n);
/////////////////////////////
//+++++++++++++++++++++++++++
// BRUTE FORCE SEARCH
//+++++++++++++++++++++++++++
/////////////////////////////

//+++++++++++++++++++++++++++
// MAIN FEATURES
//+++++++++++++++++++++++++++
//no preprocessing phase;
//constant extra space needed;
//always shifts the window by exactly 1 position to the right;
//comparisons can be done in any order;
//searching phase in O(mn) time complexity;
//2n expected text characters comparisons.

//Description
//The brute force algorithm consists in checking, at all positions in the text between 0 and n-m,
//whether an occurrence of the pattern starts there or not. Then, after each attempt,
//it shifts the pattern by exactly one position to the right.

//The brute force algorithm requires no preprocessing phase,
//and a constant extra space in addition to the pattern and the text.
//During the searching phase the text character comparisons can be done in any order.
//The time complexity of this searching phase is O(mn) (when searching for am-1b in an for instance).



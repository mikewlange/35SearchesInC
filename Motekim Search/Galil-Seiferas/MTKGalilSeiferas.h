//
//  MTKGalilSeiferas.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//


/////////////////////////////
//+++++++++++++++++++++++++++
// Galil-Seiferas algorithm
//+++++++++++++++++++++++++++
/////////////////////////////

//+++++++++++++++++++++++++++
// MAIN FEATURES
//+++++++++++++++++++++++++++
//constant extra space complexity;
//preprocessing phase in O(m) time and constant space complexity;
//searching phase in O(n) time complexity;
//performs 5n text character comparisons in the worst case.


#import <Foundation/Foundation.h>
#import "includeme.h"


@interface MTKGalilSeiferas : NSObject

@end

void GSGSSearch(char *argX, int argM, char *argY, int argN, int* rcQ);

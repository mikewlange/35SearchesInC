//
//  MTKShiftOr.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import <Foundation/Foundation.h>

/////////////////////////////
//+++++++++++++++++++++++++++

// Shift Or algorithm

//+++++++++++++++++++++++++++
/////////////////////////////


@interface MTKShiftOr : NSObject

@end
const char *ShiftOr(const char *text, const char *pattern);
const char *ShiftOrFuzzy(const char *text, const char *pattern);

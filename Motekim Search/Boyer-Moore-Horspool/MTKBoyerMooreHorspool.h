//
//  MTKBoyerMooreHorspool.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTKBoyerMooreHorspool : NSObject

@end
/// Boyer-Moore-Horspool algorithm (for C strings)
const char* searchBoyerMooreHorspoolString(const char* haystack, const char* needle);

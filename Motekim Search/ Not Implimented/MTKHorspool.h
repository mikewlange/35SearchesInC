//
//  MTKHorspool.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTKHorspool : NSObject

@end
uint32_t boyer_moore (uint8_t *string, uint32_t stringlen, uint8_t *pat, uint32_t patlen);

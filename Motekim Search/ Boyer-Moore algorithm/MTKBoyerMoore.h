//
//  MTKBoyerMoore.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTKBoyerMoore : NSObject

@end
void MTKBM(char *x, char *y, int* output);
void MTKBoyerMoore2(char *txt, char *pat, int * output);
uint32_t boyer_moore (uint8_t *string, uint32_t stringlen, uint8_t *pat, uint32_t patlen) ;

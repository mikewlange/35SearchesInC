//
//  MTKKMPSkip.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTKKMPSkip : NSObject

@end
//void KMPSKIP(char *x,char *y, int* output);
 
void KMPSKIP(char *x,size_t m, char *y,size_t n, int* output);

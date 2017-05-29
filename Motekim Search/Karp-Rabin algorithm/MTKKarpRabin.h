//
//  MOTKarpRabin.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTKKarpRabin : NSObject
void KR(char *x, char *y, int *outLst);
void KRsearch(char pat[], char txt[], int q, int *outLst);
@end

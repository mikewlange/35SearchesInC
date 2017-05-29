//
//  MTKColussi.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTKColussi : NSObject

@end
void COLUSSI(char *x, char *y, int *output);
int preColussi(char *x, int m, int h[], int next[], int shift[]);

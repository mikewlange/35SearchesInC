//
//  dfaa.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

/////////////////////////////
//+++++++++++++++++++++++++++

// Deterministic Finite Automaton algorithm

//+++++++++++++++++++++++++++
/////////////////////////////


#import <Foundation/Foundation.h>
#import "util.h"
@interface MTKdfaa : NSObject
{
    
}

void MTKDFAAsearch(char *pat, int M, char *txt,int N, int *output);
@end

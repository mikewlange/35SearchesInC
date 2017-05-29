//
//  RailgunTrolldom.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTKRailgun : NSObject

@end
char * Railgun_Doublet (char * pbTarget, char * pbPattern, int cbTarget, int cbPattern);
char * Railgun_Trolldom (char * pbTarget, char * pbPattern, size_t cbTarget, size_t cbPattern);

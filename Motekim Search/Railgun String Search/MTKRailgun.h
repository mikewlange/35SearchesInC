//
//  RailgunTrolldom.h
//  MotekimSearchAlgos
//
//  Created by Michael Lange on 5/28/17.
//  Copyright © 2017 motekim. All rights reserved.
//
// Railgun_Trolldom (the successor of Railgun_Swampshine_BailOut - avoiding second pattern comparison in BMH2 and pseudo-BMH4), copyleft 2016-Aug-19, Kaze.
// Railgun_Swampshine_BailOut, copyleft 2016-Aug-10, Kaze.
// Internet "home" page: http://www.codeproject.com/Articles/250566/Fastest-strstr-like-function-in-C
// My homepage (homeserver, often down): http://www.sanmayce.com/Railgun/


#import <Foundation/Foundation.h>

@interface MTKRailgun : NSObject

@end
char * Railgun_Doublet (char * pbTarget, char * pbPattern, int cbTarget, int cbPattern);
char * Railgun_Trolldom (char * pbTarget, char * pbPattern, size_t cbTarget, size_t cbPattern);

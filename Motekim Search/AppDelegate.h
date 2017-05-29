//
//  AppDelegate.h
//  Motekim Search
//
//  Created by Michael Lange on 5/29/17.
//  Copyright © 2017 motekim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


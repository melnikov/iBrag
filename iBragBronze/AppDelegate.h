//
//  AppDelegate.h
//  iBragBronze
//
//  Created by admin on 11.09.13.
//  Copyright (c) 2013 iBrag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) FBSession *session;

@end

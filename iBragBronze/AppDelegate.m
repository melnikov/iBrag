//
//  AppDelegate.m
//  iBragBronze
//
//  Created by admin on 11.09.13.
//  Copyright (c) 2013 iBrag. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Flurry.h"
#import "Chartboost.h"

@implementation AppDelegate

@synthesize session = _session;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Flurry setCrashReportingEnabled:YES];
    
	NSString * flurryKey;
	
#ifdef BLACK
	flurryKey = @"H65TQ8N5XFJ53TQF5W6J"; //black
#elif BRONZE
	flurryKey = @"YCHBCZMQJQPS68N42HMS"; //bronze
#elif SILVER
	flurryKey = @"HRJNRB7D6Y2VS89ZKXMW"; //silver
#elif PLATINUM
	flurryKey = @"8DTNKPT7NR465JQX5NZM"; //platinum
#elif GOLD
	flurryKey = @"5ZM3XX65W596XQCRH33Z"; //gold
#endif
	
	[Flurry startSession:flurryKey];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    Chartboost *cb = [Chartboost sharedChartboost];
	
#ifdef BLACK
	cb.appId = @"522ce6d917ba47221e000003"; //black
    cb.appSignature = @"8c6b8c877c6f41a04d49598997f8b05dea45d045"; //black
#elif BRONZE
	cb.appId = @"522ce73b17ba47ba1d00000b"; //bronze
    cb.appSignature = @"b1a67bccc3decdada04d14e898c76016baf33b7c"; //bronze
#elif SILVER
	cb.appId = @"522ce72816ba47e90b000007"; //silver
    cb.appSignature = @"ddd7b2c9e0889959eef0ec6c1346541870079f1e"; //silver
#elif PLATINUM
	cb.appId = @"522ce6f016ba47f70b00000b"; //platinum
    cb.appSignature = @"1359983ca71286d023a4016726a8711b07086d46"; //platinum
#elif GOLD
	cb.appId = @"522ce71716ba47880c000029"; //gold
    cb.appSignature = @"df9faa6436d45b3c8fefca25192d783e357843a6"; //gold
#endif
    
    // Required for use of delegate methods. See "Advanced Topics" section below.
    //cb.delegate = self;
    
    // Begin a user session. Must not be dependent on user actions or any prior network requests.
    // Must be called every time your app becomes active.
    [cb startSession];
    
    // Show an interstitial
    [cb showInterstitial];
	
}


- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

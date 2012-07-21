//
//  AppDelegate.m
//  SCSP
//
//  Created by Billy Connolly on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MainMenuViewController.h"

@implementation AppDelegate
@synthesize window = _window;
@synthesize rscMgr;
@synthesize cableConnected;
@synthesize loggedIn;
@synthesize navController;

- (void)dealloc{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey: @"Passcode"] == nil){
        [[NSUserDefaults standardUserDefaults] setObject:@"1111" forKey:@"Passcode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    self.rscMgr = [[RscMgr alloc] init];
    [rscMgr setDelegate: self];
    [rscMgr setBaud: 9600];
    cableConnected = NO;
    
    self.loggedIn = NO;
    
    MainMenuViewController *mmvc = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    self.navController = [[UINavigationController alloc] initWithRootViewController:mmvc];
    [navController setNavigationBarHidden: YES];
    [self.window addSubview: navController.view];  
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)cableConnected:(NSString *)protocol{
    cableConnected = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CableNotification" object:[NSNumber numberWithBool: YES]];
}

- (void)cableDisconnected{
    if([[navController viewControllers] count] == 1){
        MainMenuViewController *mmvc = (MainMenuViewController *)[[navController viewControllers] objectAtIndex: 0];
        [mmvc logout: nil];
    }else if([[navController viewControllers] count] > 1){
        [navController popToRootViewControllerAnimated: YES];
        MainMenuViewController *mmvc = (MainMenuViewController *)[[navController viewControllers] objectAtIndex: 0];
        [mmvc logout: nil];
    }
    
    cableConnected = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CableNotification" object:[NSNumber numberWithBool: NO]];
}

- (void)portStatusChanged{
    
}

- (void)readBytesAvailable:(UInt32)numBytes{
    UInt8 data[numBytes];    
    int numBytesRead = [rscMgr read:&data[0] Length:numBytes];
    
    if(data[0] == 'T'){
        NSString *string = @"";
        for(int x = 1; x < numBytesRead; x++){
            string = [string stringByAppendingString: [NSString stringWithFormat: @"%c", data[x]]];
        }
        
        float temperature = [string floatValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TemperatureNotification" object:[NSNumber numberWithFloat: temperature]];
    }
}

- (BOOL)rscMessageReceived:(UInt8 *)msg TotalLength:(int)len{
    return FALSE;    
}

- (void)didReceivePortConfig{
    
}

- (void)applicationWillResignActive:(UIApplication *)application{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

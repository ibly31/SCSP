//
//  AppDelegate.h
//  SCSP
//
//  Created by Billy Connolly on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RscMgr.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, RscMgrDelegate>{
    BOOL cableConnected;
    RscMgr *rscMgr;
    
    UINavigationController *navController;
    
    BOOL loggedIn;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) RscMgr *rscMgr;
@property BOOL cableConnected;
@property BOOL loggedIn;

@end

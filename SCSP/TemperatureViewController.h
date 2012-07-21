//
//  TemperatureViewController.h
//  SCSP
//
//  Created by Billy Connolly on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemperatureGraphView.h"
#import "CableLabel.h"

@class MainMenuViewController;

@interface TemperatureViewController : UIViewController{
    MainMenuViewController *delegate;
    TemperatureGraphView *temperatureGraphView;
    CableLabel *cableLabel;
}

@property (nonatomic, retain) MainMenuViewController *delegate;
@property (nonatomic, retain) TemperatureGraphView *temperatureGraphView;
@property (nonatomic, retain) CableLabel *cableLabel;

- (IBAction)clearHistory:(id)sender;

@end

//
//  MainMenuViewController.h
//  SCSP
//
//  Created by Billy Connolly on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CableLabel.h"
#import "NumpadViewController.h"

@interface MainMenuViewController : UIViewController <NumpadViewControllerDelegate, UIAlertViewDelegate>{
    UIButton *keypadButton;
    UIButton *temperatureButton;
    UIButton *mapButton;
    UIButton *settingsButton;
    
    CableLabel *cableLabel;
}

@property (nonatomic, retain) IBOutlet UIButton *keypadButton;
@property (nonatomic, retain) IBOutlet UIButton *temperatureButton;
@property (nonatomic, retain) IBOutlet UIButton *mapButton;
@property (nonatomic, retain) IBOutlet UIButton *settingsButton;

@property (nonatomic, retain) CableLabel *cableLabel;

- (IBAction)numpad:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)temperature:(id)sender;
- (IBAction)map:(id)sender;
- (IBAction)settings:(id)sender;

- (void)didUnlock;
- (void)swapButtons;

@end

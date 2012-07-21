//
//  SettingsViewController.h
//  SCSP
//
//  Created by Billy Connolly on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumpadViewController.h"

@interface SettingsViewController : UIViewController <UITextFieldDelegate, NumpadViewControllerDelegate>{
    UIButton *changeButton;
    
    NSString *lastCode;
    BOOL settingCode;
}

@property (nonatomic, retain) IBOutlet UIButton *changeButton;

- (IBAction)goBack:(id)sender;
- (IBAction)changePasscode:(id)sender;

@end

//
//  NumpadViewController.h
//  SCSP
//
//  Created by Billy Connolly on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CableLabel.h"
#import "RoundedSendingView.h"

@class NumpadViewController;

@protocol NumpadViewControllerDelegate <NSObject>

- (void)passcodeController:(NumpadViewController *)controller passcodeEntered:(NSString *)passCode;

@end

typedef enum {
    PasscodeAnimationStyleNone,
    PasscodeAnimationStyleInvalid,
    PasscodeAnimationStyleConfirm
} PasscodeAnimationStyle;

@class MainMenuViewController;

@interface NumpadViewController : UIViewController <UITextFieldDelegate>{
    id <NumpadViewControllerDelegate> delegate;
    
    IBOutlet UIView *animationView;
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *instructionLabel;
    
    IBOutlet UITextField *bulletField0;
    IBOutlet UITextField *bulletField1;
    IBOutlet UITextField *bulletField2;
    IBOutlet UITextField *bulletField3;
    
    UINavigationItem *navBarTitle;
    
    UITextField *fakeField;
    
    BOOL passcodeSetting;
    
    CableLabel *cableLabel;
    RoundedSendingView *rsv;
}

@property (nonatomic, retain) CableLabel *cableLabel;

@property (nonatomic, assign) id <NumpadViewControllerDelegate> delegate; 

@property (nonatomic, retain) IBOutlet UIView *animationView;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *instructionLabel;

@property (nonatomic, retain) IBOutlet UINavigationItem *navBarTitle;

@property (nonatomic, retain) IBOutlet UITextField *bulletField0;
@property (nonatomic, retain) IBOutlet UITextField *bulletField1;
@property (nonatomic, retain) IBOutlet UITextField *bulletField2;
@property (nonatomic, retain) IBOutlet UITextField *bulletField3;
@property (nonatomic, retain) RoundedSendingView *rsv;

@property BOOL passcodeSetting;

- (void)resetWithAnimation:(PasscodeAnimationStyle)animationStyle;
- (IBAction)goBack:(id)sender;

@end

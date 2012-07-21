//
//  SettingsViewController.m
//  SCSP
//
//  Created by Billy Connolly on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController
@synthesize changeButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        lastCode = @"";
        settingCode = NO;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIImage *blueButtonImage = [UIImage imageNamed:@"BlueButton.png"];
    UIImage *stretchedBlueButton = [blueButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    UIImage *blueButtonTapImage = [UIImage imageNamed:@"BlueButtonTap.png"];
    UIImage *stretchedBlueButtonTap = [blueButtonTapImage stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    UIImage *grayButtonImage = [UIImage imageNamed:@"GrayButton.png"];
    UIImage *stretchedGrayButton = [grayButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:12];        
    
    [changeButton setBackgroundImage:stretchedBlueButton forState:UIControlStateNormal];
    [changeButton setBackgroundImage:stretchedBlueButtonTap forState:UIControlStateHighlighted];
    [changeButton setBackgroundImage:stretchedGrayButton forState:UIControlStateDisabled];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([string length] > 0){
        return [[textField text] length] < 4;
    }else{
        return YES;
    }
}

- (IBAction)changePasscode:(id)sender{ 
    NumpadViewController *nvc = [[NumpadViewController alloc] initWithNibName:@"NumpadViewController" bundle:nil];
    [nvc setDelegate: self];
    [nvc setPasscodeSetting: YES];
    [self presentModalViewController:nvc animated:YES];
    [nvc release];
}

- (void)passcodeController:(NumpadViewController *)controller passcodeEntered:(NSString *)passCode{
    if(!settingCode){
        if([passCode isEqualToString: [[NSUserDefaults standardUserDefaults] objectForKey:@"Passcode"]]){
            settingCode = YES;
            lastCode = nil;
            controller.instructionLabel.text = @"Please enter new passcode.";
            [controller resetWithAnimation: PasscodeAnimationStyleConfirm];
        }else{
            [controller resetWithAnimation: PasscodeAnimationStyleInvalid];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Passcode does not match existing passcode, please try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }else{
        if(lastCode == nil){
            lastCode = [passCode retain];
            controller.instructionLabel.text = @"Please confirm passcode.";
            [controller resetWithAnimation: PasscodeAnimationStyleConfirm];
        }else{
            if([passCode isEqualToString: lastCode]){
                [[NSUserDefaults standardUserDefaults] setObject:passCode forKey:@"Passcode"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [controller dismissModalViewControllerAnimated: YES];                
            }else{
                settingCode = YES;
                lastCode = nil;
                controller.instructionLabel.text = @"Please enter new passcode.";
                [controller resetWithAnimation: PasscodeAnimationStyleInvalid];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Passcodes do not match, please try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
    }
}

/*
- (IBAction)changePasscode:(id)sender{
    if([[oldCodeField text] length] == 4 && [[codeField text] length] == 4){
        if([[oldCodeField text] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"Passcode"]]){
            [[NSUserDefaults standardUserDefaults] setObject:[codeField text] forKey:@"Passcode"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [oldCodeField setText: @""];
            [codeField setText: @""];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The passcode entered is not equal to the old pass code." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
}*/

- (IBAction)goBack:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

//
//  NumpadViewController.m
//  SCSP
//
//  Created by Billy Connolly on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NumpadViewController.h"
#import "MainMenuViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioServices.h>

@interface NumpadViewController ()

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
- (void)internalResetWithAnimation:(NSNumber *)animationStyleNumber;
- (void)notifyDelegate:(NSString *)passcode;

@end

@implementation NumpadViewController
@synthesize cableLabel;
@synthesize delegate;

@synthesize animationView;

@synthesize titleLabel;
@synthesize instructionLabel;
@synthesize navBarTitle;

@synthesize bulletField0;
@synthesize bulletField1;
@synthesize bulletField2;
@synthesize bulletField3;

@synthesize passcodeSetting;
@synthesize rsv;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.passcodeSetting = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(passcodeSetting){
        [self.navBarTitle setTitle: @"Set passcode"];
    }else{
        [self.navBarTitle setTitle: @"Log in"];
        self.cableLabel = [[CableLabel alloc] initWithFrame: CGRectMake(0, 52, 320, 21)];
        [self.view addSubview: cableLabel];
    }
    
    fakeField = [[UITextField alloc] initWithFrame:CGRectZero];
    fakeField.delegate = self;
    fakeField.keyboardType = UIKeyboardTypeNumberPad;
    fakeField.secureTextEntry = YES;
    fakeField.text = @"";
    [fakeField becomeFirstResponder];
    [self.view addSubview:fakeField];
    [fakeField release];
    
    self.rsv = [[RoundedSendingView alloc] initWithYLocation: 30];
    [self.view addSubview: rsv];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    fakeField = nil;
    
    self.animationView = nil;
    
    self.titleLabel = nil;
    self.instructionLabel = nil;
    
    self.bulletField0 = nil;
    self.bulletField1 = nil;
    self.bulletField2 = nil;
    self.bulletField3 = nil;
}

- (void)internalResetWithAnimation:(NSNumber *)animationStyleNumber {    
    PasscodeAnimationStyle animationStyle = [animationStyleNumber intValue];
    switch(animationStyle){
        case PasscodeAnimationStyleInvalid:
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            
            /*CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
             [animation setDelegate:self]; 
             [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
             [animation setDuration:0.025];
             [animation setRepeatCount:8];
             [animation setAutoreverses:YES];
             [animation setFromValue:[NSValue valueWithCGPoint:
             CGPointMake([animationView center].x - 14.0f, [animationView center].y)]];
             [animation setToValue:[NSValue valueWithCGPoint:
             CGPointMake([animationView center].x + 14.0f, [animationView center].y)]];
             [[animationView layer] addAnimation:animation forKey:@"position"];*/
            break;
        case PasscodeAnimationStyleConfirm:            
            self.bulletField0.text = nil;
            self.bulletField1.text = nil;
            self.bulletField2.text = nil;
            self.bulletField3.text = nil;
            
            CATransition *transition = [CATransition animation]; 
            [transition setDelegate:self]; 
            [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
            [transition setType:kCATransitionPush]; 
            [transition setSubtype:kCATransitionFromRight]; 
            [transition setDuration:0.5f];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]]; 
            [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1]; 
            [[animationView layer] addAnimation:transition forKey:@"swipe"];
            break;
        case PasscodeAnimationStyleNone:
        default:
            self.bulletField0.text = nil;
            self.bulletField1.text = nil;
            self.bulletField2.text = nil;
            self.bulletField3.text = nil;
            
            fakeField.text = @"";
            break;
    }
}

- (void)resetWithAnimation:(PasscodeAnimationStyle)animationStyle {   
    [self performSelector:@selector(internalResetWithAnimation:) withObject:[NSNumber numberWithInt:animationStyle] afterDelay:0];
}

- (void)notifyDelegate:(NSString *)passcode {
    [self.delegate passcodeController:self passcodeEntered:passcode];
    fakeField.text = @"";
}

- (IBAction)goBack:(id)sender{
    [self dismissModalViewControllerAnimated: YES];
}

#pragma mark - CAAnimationDelegate 
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.bulletField0.text = nil;
    self.bulletField1.text = nil;
    self.bulletField2.text = nil;
    self.bulletField3.text = nil;
    
    fakeField.text = @"";
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *passcode = [textField text];
    passcode = [passcode stringByReplacingCharactersInRange:range withString:string];
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(passcodeSetting || [del cableConnected]){
        switch ([passcode length]) {
            case 0:
                self.bulletField0.text = nil;
                self.bulletField1.text = nil;
                self.bulletField2.text = nil;
                self.bulletField3.text = nil;
                break;
            case 1:
                self.bulletField0.text = @"*";
                self.bulletField1.text = nil;
                self.bulletField2.text = nil;
                self.bulletField3.text = nil;
                break;
            case 2:
                self.bulletField0.text = @"*";
                self.bulletField1.text = @"*";
                self.bulletField2.text = nil;
                self.bulletField3.text = nil;
                break;
            case 3:
                self.bulletField0.text = @"*";
                self.bulletField1.text = @"*";
                self.bulletField2.text = @"*";
                self.bulletField3.text = nil;
                break;
            case 4:
                self.bulletField0.text = @"*";
                self.bulletField1.text = @"*";
                self.bulletField2.text = @"*";
                self.bulletField3.text = @"*";
                
                // Notify delegate a little later so we have a chance to show the 4th bullet
                [self performSelector:@selector(notifyDelegate:) withObject:passcode afterDelay:0];
                return NO;
                break;
            default:
                break;
        }
    }else{
        [cableLabel flashRed];
    }
    
    return YES;
}

- (void)dealloc {
    [animationView release], animationView = nil;
    
    [titleLabel release], titleLabel = nil;
    [instructionLabel release], instructionLabel = nil;
    
    [bulletField0 release], bulletField0 = nil;
    [bulletField1 release], bulletField1 = nil;
    [bulletField2 release], bulletField2 = nil;
    [bulletField3 release], bulletField3 = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

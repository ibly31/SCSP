//
//  MainMenuViewController.m
//  SCSP
//
//  Created by Billy Connolly on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"
#import "NumpadViewController.h"
#import "TemperatureViewController.h"
#import "SettingsViewController.h"
#import "MapViewController.h"
#import "AppDelegate.h"

@implementation MainMenuViewController
@synthesize keypadButton;
@synthesize temperatureButton;
@synthesize mapButton;
@synthesize settingsButton;
@synthesize cableLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.cableLabel = [[CableLabel alloc] initWithFrame: CGRectMake(0, 337, 320, 21)];
    [self.view addSubview: cableLabel];
    
    UIImage *blueButtonImage = [UIImage imageNamed:@"BlueButton.png"];
    UIImage *stretchedBlueButton = [blueButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    UIImage *blueButtonTapImage = [UIImage imageNamed:@"BlueButtonTap.png"];
    UIImage *stretchedBlueButtonTap = [blueButtonTapImage stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    UIImage *grayButtonImage = [UIImage imageNamed:@"GrayButton.png"];
    UIImage *stretchedGrayButton = [grayButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:12];        
    
    [keypadButton setBackgroundImage:stretchedBlueButton forState:UIControlStateNormal];
    [keypadButton setBackgroundImage:stretchedBlueButtonTap forState:UIControlStateHighlighted];
    [keypadButton setBackgroundImage:stretchedGrayButton forState:UIControlStateDisabled];
    [temperatureButton setBackgroundImage:stretchedBlueButton forState:UIControlStateNormal];
    [temperatureButton setBackgroundImage:stretchedBlueButtonTap forState:UIControlStateHighlighted];
    [temperatureButton setBackgroundImage:stretchedGrayButton forState:UIControlStateDisabled];
    [mapButton setBackgroundImage:stretchedBlueButton forState:UIControlStateNormal];
    [mapButton setBackgroundImage:stretchedBlueButtonTap forState:UIControlStateHighlighted];
    [mapButton setBackgroundImage:stretchedGrayButton forState:UIControlStateDisabled];
    [settingsButton setBackgroundImage:stretchedBlueButton forState:UIControlStateNormal];
    [settingsButton setBackgroundImage:stretchedBlueButtonTap forState:UIControlStateHighlighted];
    [settingsButton setBackgroundImage:stretchedGrayButton forState:UIControlStateDisabled];
}

- (IBAction)numpad:(id)sender{
    NumpadViewController *nvc = [[NumpadViewController alloc] initWithNibName:@"NumpadViewController" bundle:nil];
    [nvc setDelegate: self];
    [self presentModalViewController:nvc animated:YES];    
    [nvc release];
}

- (IBAction)logout:(id)sender{
    [keypadButton removeTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [keypadButton addTarget:self action:@selector(numpad:) forControlEvents:UIControlEventTouchUpInside];
    [keypadButton setTitle:@"Log in" forState:UIControlStateNormal];
    [temperatureButton setEnabled: NO];
    [mapButton setEnabled: NO];
    [settingsButton setEnabled: NO];
    if([keypadButton frame].origin.y != 130){
        [self swapButtons];
    }
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [del setLoggedIn: YES];
}

- (IBAction)temperature:(id)sender{
    TemperatureViewController *tvc = [[TemperatureViewController alloc] initWithNibName:@"TemperatureViewController" bundle:nil];
    [tvc setDelegate: self];
    [self.navigationController pushViewController:tvc animated:YES];
    [tvc release];
}

- (IBAction)map:(id)sender{
    MapViewController *mvc = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [mvc setDelegate: self];
    [self.navigationController pushViewController:mvc animated:YES];
    [mvc release];
}

- (IBAction)settings:(id)sender{
    SettingsViewController *svc = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [self presentModalViewController:svc animated:YES];
    [svc release];
}

- (void)passcodeController:(NumpadViewController *)controller passcodeEntered:(NSString *)passCode{
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    RscMgr *rscMgr = [del rscMgr];
    
    if([del cableConnected] && [passCode isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"Passcode"]]){
        [[controller rsv] fadeIn];
        [[controller rsv] performSelector:@selector(fadeOut) withObject:nil afterDelay:0.5f];
        [controller dismissModalViewControllerAnimated:YES];
        [self performSelector:@selector(didUnlock) withObject:nil afterDelay:0.25f];
        
        UInt8 secretCode[4];
        secretCode[0] = 'U';
        secretCode[1] = 'L';
        secretCode[2] = 'O';
        secretCode[3] = 'C';
        
        [rscMgr write:&secretCode[0] Length:4];
    }else{
        controller.instructionLabel.text = [NSString stringWithFormat:@"You entered: '%@'. Try '1111', it's the default.", passCode];
        [controller resetWithAnimation: PasscodeAnimationStyleInvalid];
    }
}

- (void)didUnlock{
    [keypadButton removeTarget:self action:@selector(numpad:) forControlEvents:UIControlEventTouchUpInside];
    [keypadButton addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [keypadButton setTitle:@"Log out" forState:UIControlStateNormal];
    [temperatureButton setEnabled: YES];
    [mapButton setEnabled: YES];
    [settingsButton setEnabled: YES];
    if([keypadButton frame].origin.y == 130){
        [self swapButtons];
    }
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [del setLoggedIn: YES];
}

- (void)swapButtons{
    CGRect keypadRect = [keypadButton frame];
    [UIView beginAnimations:@"ButtonSwap" context:nil];
    [keypadButton setFrame: [mapButton frame]];
    [mapButton setFrame: keypadRect];
    [UIView commitAnimations];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

//
//  TemperatureViewController.m
//  SCSP
//
//  Created by Billy Connolly on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TemperatureViewController.h"

@implementation TemperatureViewController
@synthesize delegate;
@synthesize temperatureGraphView;
@synthesize cableLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Temperature";
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.cableLabel = [[CableLabel alloc] initWithFrame: CGRectMake(0, 8, 320, 21)];
    [self.view addSubview: cableLabel];
    
    self.temperatureGraphView = [[TemperatureGraphView alloc] initWithFrame:CGRectMake(0, 36, 320, 320)];
    [self.view addSubview: temperatureGraphView];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (IBAction)clearHistory:(id)sender{
    [temperatureGraphView clearHistory];
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

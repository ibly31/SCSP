//
//  CableLabel.m
//  SCSP
//
//  Created by Billy Connolly on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CableLabel.h"
#import "AppDelegate.h"

@implementation CableLabel
@synthesize cableLabel;
@synthesize connectedLabel;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, frame.origin.y, 320, 21)];
    if (self) {
        self.cableLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 21)];
        [cableLabel setText:@"Cable:"];
        [cableLabel setBackgroundColor: [UIColor clearColor]];
        [self addSubview:cableLabel];
        
        self.connectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 0, 221, 21)];
        [connectedLabel setText:@"Not Connected"];
        [connectedLabel setTextColor:[UIColor redColor]];
        [connectedLabel setBackgroundColor: [UIColor clearColor]];
        [connectedLabel setTextAlignment:UITextAlignmentRight];
        [self addSubview:connectedLabel];
        
        isConnected = [(AppDelegate *)[[UIApplication sharedApplication] delegate] cableConnected];
        [self setConnected:isConnected animated:NO];
        
        [self setBackgroundColor: [UIColor clearColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNotification:) name:@"CableNotification" object:nil];
        
    }
    return self;
}

- (void)recieveNotification:(NSNotification *)notification{
    if([[notification name] isEqualToString:@"CableNotification"]){
        [self setConnected:[[notification object] boolValue]];
    }
}

- (void)flashRed{
    self.backgroundColor = [UIColor redColor];      
    [UIView animateWithDuration:0.25f animations:^{
            self.backgroundColor = [UIColor clearColor];
    }];
    
}
         
- (void)setConnected:(BOOL)connected animated:(BOOL)animated{
    isConnected = connected;
    if(connected){
        [connectedLabel setText:@"Connected"];
        [connectedLabel setTextColor: [UIColor colorWithRed:0.0f green:0.7f blue:0.0f alpha:1.0f]];
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.7f blue:0.0f alpha:1.0f];
        if(animated){
            [UIView animateWithDuration:0.25f animations:^{
                self.backgroundColor = [UIColor clearColor];
            }];
        }else{
            self.backgroundColor = [UIColor clearColor];
        }
    }else{
        [connectedLabel setText:@"Not Connected"];
        [connectedLabel setTextColor: [UIColor redColor]];
        self.backgroundColor = [UIColor redColor];
        if(animated){
            [UIView animateWithDuration:0.25f animations:^{
                self.backgroundColor = [UIColor clearColor];
            }];
        }else{
            self.backgroundColor = [UIColor clearColor];
        }
    }
}

- (void)setConnected:(BOOL)connected{
    [self setConnected:connected animated:YES];
}

@end

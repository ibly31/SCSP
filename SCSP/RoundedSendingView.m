//
//  RoundedUnlockView.m
//  SCSP
//
//  Created by Billy Connolly on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RoundedSendingView.h"
#import <QuartzCore/QuartzCore.h>

@implementation RoundedSendingView
@synthesize label;
@synthesize activityIndicator;

- (id)initWithYLocation:(int)loc{
    self = [super initWithFrame:CGRectMake(50, loc, 220, 90)];
    if(self){
        self.label = [[UILabel alloc] initWithFrame: CGRectMake(12, 70, 140, 20)];
        [label setFont: [UIFont systemFontOfSize: 18.0f]];
        [label setBackgroundColor: [UIColor clearColor]];
        [label setTextColor: [UIColor whiteColor]];
        [label setTextAlignment: UITextAlignmentCenter];
        [label setText:@"Sending to Arduino..."];
        [self addSubview: label];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(62, 20, 36, 36)];
        
        [activityIndicator setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhiteLarge];
        [activityIndicator setBackgroundColor: [UIColor clearColor]];
        [self addSubview: activityIndicator];
        [activityIndicator startAnimating];
        
        [self setBackgroundColor: [UIColor colorWithWhite:0.2f alpha:1.0f]];
        self.layer.cornerRadius = 10.0f;
        self.layer.masksToBounds = YES;
        self.layer.shadowOffset = CGSizeMake(1, 0);
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = .25;
        
        [self setHidden: YES];
        [self setAlpha: 0.0f];
        
        [self setTag: 11];
    }
    return self;
}

- (void)fadeIn{
    [self setAlpha: 0.0f];
    [self setHidden: NO];
    [UIView beginAnimations:@"RSV Fade" context:nil];
    [UIView setAnimationDuration:0.25f];
    [self setAlpha: 1.0f];
    [UIView commitAnimations];
}

- (void)fadeOut{
    [self setAlpha: 1.0f];
    [self setHidden: NO];
    [UIView beginAnimations:@"RSV Fade" context:nil];
    [UIView setAnimationDuration:0.25f];
    [self setAlpha: 0.0f];
    [UIView commitAnimations];
    [self performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] afterDelay:0.5f];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

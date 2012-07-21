//
//  RoundedSendingView.h
//  SCSP
//
//  Created by Billy Connolly on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundedSendingView : UIView{
    UILabel *label;
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

- (id)initWithYLocation:(int)loc;

- (void)fadeOut;
- (void)fadeIn;

@end

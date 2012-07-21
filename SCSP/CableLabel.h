//
//  CableLabel.h
//  SCSP
//
//  Created by Billy Connolly on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CableLabel : UIView{
    UILabel *cableLabel;
    UILabel *connectedLabel;
    BOOL isConnected;
}

@property (nonatomic, retain) IBOutlet UILabel *cableLabel;
@property (nonatomic, retain) IBOutlet UILabel *connectedLabel;

- (void)setConnected:(BOOL)connected;
- (void)setConnected:(BOOL)connected animated:(BOOL)animated;
- (void)recieveNotification:(NSNotification *)notification;

- (void)flashRed;

@end

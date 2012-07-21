//
//  TemperatureGraphView.h
//  SCSP
//
//  Created by Billy Connolly on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define barsAcross 10

@interface TemperatureGraphView : UIView{
    NSMutableArray *temperatureArray;
    int offset;
    
    UILabel *temperatureLabel;
    
    CGPoint previousTouch;
}

@property (nonatomic, retain) NSMutableArray *temperatureArray;
@property (nonatomic, retain) UILabel *temperatureLabel;

- (void)addTemperature:(float)temperature;
- (void)recieveNotification:(NSNotification *)notification;
- (void)clearHistory;

@end

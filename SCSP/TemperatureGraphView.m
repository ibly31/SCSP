//
//  TemperatureGraphView.m
//  SCSP
//
//  Created by Billy Connolly on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TemperatureGraphView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TemperatureGraphView
@synthesize temperatureArray;
@synthesize temperatureLabel;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.temperatureArray = [[NSMutableArray alloc] init];
        [self setBackgroundColor: [UIColor blackColor]];
        
        self.temperatureLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 8, 320, 80)];
        [temperatureLabel setTextColor: [UIColor redColor]];
        [temperatureLabel setBackgroundColor: [UIColor clearColor]];
        [temperatureLabel setTextAlignment: UITextAlignmentCenter];
        [temperatureLabel setFont: [UIFont systemFontOfSize: 72.0f]];
        [self addSubview: temperatureLabel];
        
        offset = 0;
        previousTouch = CGPointMake(-1, -1);
        
        self.layer.borderColor = [UIColor greenColor].CGColor;
        self.layer.borderWidth = 3.0f;
        
        UIImageView *scaleView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Scale.png"]];
        [scaleView setFrame: CGRectMake(288, 0, 32, 320)];
        [self addSubview: scaleView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNotification:) name:@"TemperatureNotification" object:nil];
    }
    return self;
}

- (void)addTemperature:(float)temperature{
    [temperatureArray insertObject:[NSNumber numberWithFloat:temperature] atIndex:0];
    [temperatureLabel setText: [NSString stringWithFormat:@"%.2f", temperature]];
    //[self setNeedsDisplay];
    [self setNeedsDisplayInRect: self.frame];
}

- (void)recieveNotification:(NSNotification *)notification{
    if([[notification name] isEqualToString:@"TemperatureNotification"]){
        [self addTemperature: [[notification object] floatValue]];
        /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Read data" message:[NSString stringWithFormat:@"%f", [[notification object] floatValue]] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
        [alert release];*/
    }
}

- (void)clearHistory{
    [temperatureArray release];
    temperatureArray = nil;
    [temperatureLabel setText:@""];
    self.temperatureArray = [[NSMutableArray alloc] init];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(c, [UIColor greenColor].CGColor);
    float lineWidth = 320.0f / barsAcross;
    CGContextSetLineWidth(c, lineWidth);
    
    for(int x = 0; x < [temperatureArray count]; x++){//(barsAcross < [temperatureArray count]) ? barsAcross : [temperatureArray count]; x++){
        float y = [[temperatureArray objectAtIndex: x] floatValue];
        CGContextBeginPath(c);
        CGContextMoveToPoint(c, 256 - (x - .5f) * lineWidth, 320);
        CGContextAddLineToPoint(c, 256 - (x - .5f) * lineWidth, 320 - ((y - 40.0)/ 80.0) * 320.0);
        CGContextStrokePath(c);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

@end

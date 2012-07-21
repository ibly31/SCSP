//
//  MapViewController.h
//  SCSP
//
//  Created by Billy Connolly on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CableLabel.h"

@class MainMenuViewController;

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
    MainMenuViewController *delegate;
    CableLabel *cableLabel;
    
    MKMapView *mapView;
    MKOverlayPathView *pathOverlay;
    
    UIToolbar *toolbar;
    
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) MainMenuViewController *delegate;
@property (nonatomic, retain) CableLabel *cableLabel;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) MKOverlayPathView *pathOverlay;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) CLLocationManager *locationManager;

@property (nonatomic, retain) IBOutlet UILabel *printLabel;

@end

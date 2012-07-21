//
//  MapViewController.m
//  SCSP
//
//  Created by Billy Connolly on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MainMenuViewController.h"

@implementation MapViewController
@synthesize delegate;
@synthesize mapView;
@synthesize pathOverlay;
@synthesize cableLabel;
@synthesize toolbar;
@synthesize printLabel;
@synthesize locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = @"Map";
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [mapView setShowsUserLocation: YES];
    [mapView setMapType:MKMapTypeHybrid];
        
    self.cableLabel = [[CableLabel alloc] initWithFrame: CGRectMake(0, 4, 320, 21)];
    [self.view addSubview: cableLabel];
    
    MKUserTrackingBarButtonItem *userTrackingBarButtonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView: mapView];
    
    [toolbar setItems: [NSArray arrayWithObjects: userTrackingBarButtonItem, nil]];
    [userTrackingBarButtonItem release];
        
    self.locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    /*if(newLocation != nil && oldLocation != nil){
        CGFloat dx = newLocation.coordinate.latitude - oldLocation.coordinate.latitude;
        CGFloat dy = newLocation.coordinate.longitude - oldLocation.coordinate.longitude;
        float changeDistance = sqrtf(dx*dx + dy*dy);
        if([newLocation horizontalAccuracy] < 10 && [newLocation verticalAccuracy] < 10){
            path[whichCoordinate] = newLocation.coordinate;
            whichCoordinate++;
            
            MKPolyline *line = [MKPolyline polylineWithCoordinates:path count:whichCoordinate + 1];
            [mapView addOverlay:line];
            
            NSLog(@"New:%@\n\nOld:%@\n\n", newLocation, oldLocation);
            [printLabel setText: [NSString stringWithFormat: @"%f", changeDistance]];
            
            NSLog(@"%f", changeDistance);
        }
    }*/
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
    if ([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineView *aView = [[MKPolylineView alloc] initWithPolyline:(MKPolyline *)overlay];
        aView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        aView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        aView.lineCap = kCGLineCapRound;
        aView.lineJoin = kCGLineJoinRound;
        aView.lineWidth = 8;
        return aView;
    }
    return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {  
    CLLocation *pointNew = [change objectForKey:@"new"];
    CLLocation *pointOld = [change objectForKey:@"old"];
    
    NSLog(@"Old: %@\n\nNew: %@\n\n", pointOld, pointNew);
    
    /*if(pointNew != nil && pointOld != nil){
        CGFloat dx = pointNew.coordinate.latitude - pointOld.coordinate.latitude;
        CGFloat dy = pointNew.coordinate.longitude - pointOld.coordinate.longitude;
        float changeDistance = sqrtf(dx*dx + dy*dy);
        
        if(changeDistance < 100){
            [printLabel setText: [NSString stringWithFormat: @"%f", changeDistance]];
            NSLog(@"%f", changeDistance);
        }
            
    }*/
    /*MKPolyline *line = [MKPolyline polylineWithCoordinates:points count:whichCoordinate];
    [mapView addOverlay:line];*/

}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)dealloc{
    mapView.delegate = nil;
    locationManager.delegate = nil;
    
    [mapView release];
    [locationManager release];
    [super dealloc];
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

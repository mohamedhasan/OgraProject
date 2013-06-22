//
//  ViewController.h
//  OgraProject
//
//  Created by Mohammed Hasan on 10/6/12.
//  Copyright (c) 2012 Mohammed Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "CoreLocation/CoreLocation.h"
#import "Annotation.h"
#import "GeoCode.h"
#import "NetConnect.h"

CLLocationCoordinate2D cliked;

@interface ViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,GeocodeProtocol,UIAlertViewDelegate>

@property (nonatomic,retain)NetConnect *connect;
 @property(nonatomic,retain)CLGeocoder *coder;
@property(nonatomic,strong)IBOutlet MKMapView* map ;
@property(nonatomic)CLLocationManager *locationManager;
@property(nonatomic,strong)NSMutableDictionary *geoData;

@end

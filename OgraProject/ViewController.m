//
//  ViewController.m
//  OgraProject
//
//  Created by Mohammed Hasan on 10/6/12.
//  Copyright (c) 2012 Mohammed Hasan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize map,locationManager,geoData,coder,connect;

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    if(self.view.tag==0)
    {
        locationManager = [[CLLocationManager alloc]init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager setDistanceFilter:kCLDistanceFilterNone];
        
        
        //long press gesture handel
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapLongPress:)];
        longPressGesture.minimumPressDuration =.4;
        [map addGestureRecognizer:longPressGesture];
        
        [self show_user_location];

    
    }
    

}


- (void)mapLongPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
        CGPoint touchLocation = [gestureRecognizer locationInView:map];
        
        CLLocationCoordinate2D coordinate;
        coordinate = [map convertPoint:touchLocation toCoordinateFromView:map];
        
        //geocoding
        GeoCode *geo=[[GeoCode alloc]init];
        geo.GeoCodeDelegate=self;
        [geo requestReverseGeoCoding:coordinate];
        
        
    }
}



-(void)show_user_location{
    
     if(CLLocationManager.locationServicesEnabled)
     {
         
         [locationManager startUpdatingLocation];
     
     }
     else {
     
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ogra.com" message:@"Please enable location Services" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: nil];
        [alert show];
     }
    
}



- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{

    MKCoordinateRegion regoin;
    regoin.center=newLocation.coordinate;

    [map setRegion:regoin];
    [locationManager stopUpdatingLocation];

}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation{
    
    
    MKPinAnnotationView *anotview=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
    anotview.pinColor=MKPinAnnotationColorPurple;
    anotview.enabled=YES;
    anotview.animatesDrop=YES;
    
    
    anotview.canShowCallout=YES;
    UIImageView *iv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ogra.png"]];
    anotview.leftCalloutAccessoryView=iv;
    anotview.rightCalloutAccessoryView=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    Annotation *ano=(Annotation*)anotview.annotation;
    if([[ano subtitle ]length]>0)
    {
        

        return anotview;
        
    }
    else return Nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)did_geoCode_succesfully:(NSMutableDictionary*)result{
    
    

    CLLocation *loc=[result objectForKey:@"location"];
    
    
    Annotation *anot=[[Annotation alloc]initWithPosition:loc.coordinate];
    NSLog(@"location : %f",loc.altitude);
    NSLog(@"name : %@",[result objectForKey:@"name"]);
    anot.title=[result objectForKey:@"name"];
    
    anot.subtitle=@"Is this place in egypt?";
    anot.tag=@"tagged";
    

    
    [map addAnnotation:anot];

}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    Annotation *ann=(Annotation*)view.annotation;
    [mapView deselectAnnotation:ann animated:YES];
    cliked=ann.coordinate;
    
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Ogra.com " message:@"check if place in egypt ? " delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil ];
    
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
   if(buttonIndex==1)
   {
       connect=[[NetConnect alloc]init];
       NSString *lng=[[NSString alloc]initWithFormat:@"%f",cliked.longitude];
       NSString *lat=[[NSString alloc]initWithFormat:@"%f",cliked.latitude];
       [connect loadRequestWithLat:lat andLong:lng];
   
   }


}




@end

//
//  GeoCode.m
//  OgraProject
//
//  Created by Mohammed Hasan on 10/6/12.
//  Copyright (c) 2012 Mohammed Hasan. All rights reserved.
//

#import "GeoCode.h"

@implementation GeoCode

@synthesize coder,GeoCodeDelegate;


- (NSMutableDictionary*)requestReverseGeoCoding:(CLLocationCoordinate2D)location
{
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:location.latitude longitude:location.longitude];
    coder=[[CLGeocoder alloc]init];
    NSMutableDictionary *geoData=[[NSMutableDictionary alloc]init];
    
    NSLog(@"before func");
    [coder reverseGeocodeLocation:loc
                completionHandler:^(NSArray* placemarks, NSError* error) {
                   
                    if (!error) {
                        
                        if ([placemarks count] > 0) {
                            // get name and administrativeArea of the first placemark
                            CLPlacemark *placemark = [placemarks objectAtIndex:0];
                            
                            [geoData setObject:placemark.name forKey:@"name"];
                            [geoData setObject:placemark.administrativeArea forKey:@"area"];
                            [geoData setObject:[placemark location] forKey:@"location"];
                        
                            [GeoCodeDelegate did_geoCode_succesfully:geoData];
                            
                            
                            
                        }
                    }else{ NSLog(@"%@",error.description);}
                }];
    
    return geoData;
    
}




@end

//
//  GeoCode.h
//  OgraProject
//
//  Created by Mohammed Hasan on 10/6/12.
//  Copyright (c) 2012 Mohammed Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"
@protocol GeocodeProtocol

-(void)did_geoCode_succesfully:(NSMutableDictionary*)result;

@end

id<GeocodeProtocol>GeoCodeDelegate;

@interface GeoCode : NSObject<CLLocationManagerDelegate>

@property(nonatomic,retain)CLGeocoder *coder;
@property(nonatomic,strong)id<GeocodeProtocol>GeoCodeDelegate;
- (NSMutableDictionary*)requestReverseGeoCoding:(CLLocationCoordinate2D)location;
@end



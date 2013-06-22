//
//  Annotation.h
//  maptrial
//
//  Created by Mohammed Hasan on 10/6/12.
//  Copyright (c) 2012 Mohammed Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"


@interface Annotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic,copy) NSString* tag;

- initWithPosition:(CLLocationCoordinate2D)coords;
@end

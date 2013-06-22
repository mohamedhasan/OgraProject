//
//  Annotation.m
//  maptrial
//
//  Created by Mohammed Hasan on 10/6/12.
//  Copyright (c) 2012 Mohammed Hasan. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation
@synthesize coordinate;
@synthesize title;
@synthesize subtitle,tag;

- initWithPosition:(CLLocationCoordinate2D)coords {
    if (self = [super init]) {
        self.coordinate = coords;
    }
    return self;
}

@end

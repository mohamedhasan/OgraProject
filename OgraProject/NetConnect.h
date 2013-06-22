//
//  NetConnect.h
//  OgraProject
//
//  Created by Mohammed Hasan on 10/7/12.
//  Copyright (c) 2012 Mohammed Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"


Boolean success;
@interface NetConnect : NSObject
@property (nonatomic,retain)NSMutableData *responseData;
-(void)loadRequestWithLat:(NSString*)latitude andLong:(NSString*)longitude;
@end

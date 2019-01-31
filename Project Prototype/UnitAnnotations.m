//
//  UnitAnnotations.m
//  Project Prototype
//
//  Created by Van Luu on 2019-01-31.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "UnitAnnotations.h"


@implementation UnitAnnotations
- (instancetype)initWithCoordinate: (CLLocationCoordinate2D)coordinate andTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        _title = title;
        _coordinate = coordinate;
    }
    return self;
}

@end

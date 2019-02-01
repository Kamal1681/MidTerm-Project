//
//  UnitAnnotations.m
//  Project Prototype
//
//  Created by Kamal Maged, Van Luu, Paul Uvarov on 2019-01-29.
//  Copyright © 2019 Kamal Maged, Van Luu, Paul Uvarov. All rights reserved.
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

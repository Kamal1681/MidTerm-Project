//
//  Unit.m
//  Project Prototype
//
//  Created by Kamal Maged on 2019-01-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "Unit.h"

@implementation Unit
- (instancetype)initWithUnitDescription: (NSString *) unitDescription City: (NSString *) city NumberOfRooms: (NSUInteger) numberOfRooms Price: (NSNumber *) price andArea: (NSUInteger) area
{
    self = [super init];
    if (self) {
        _city = city;
        _numberOfRooms = numberOfRooms;
        _price = price;
        _unitDescription = unitDescription;
        _area = area;
    }
    return self;
}
@end

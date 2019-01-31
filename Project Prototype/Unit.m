//
//  Unit.m
//  Project Prototype
//
//  Created by Kamal Maged on 2019-01-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "Unit.h"

@implementation Unit
+ (Unit *)fromJsonDictionary:(NSMutableDictionary *)dictionary {
    NSLog (@"%@", dictionary[@"address"][@"city"]);
    
    Unit *unit = [[Unit alloc] init];
    unit.city = dictionary[@"address"][@"city"];
    unit.photos = dictionary[@"photos"];
    unit.numberOfRooms = [dictionary[@"property"][@"bedrooms"]integerValue];
    unit.price = dictionary[@"listPrice"];
    unit.unitDescription = dictionary[@"remarks"];
    unit.area = [dictionary[@"property"][@"area"]integerValue];
    unit.latitude = dictionary[@"geo"][@"latitude"];
    unit.longitude = dictionary[@"geo"][@"longitude"];
    unit.address = dictionary[@"address"][@"full"];
    
    
    return unit;
}
@end

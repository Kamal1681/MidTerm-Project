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
//    unit.photos = dictionary[@"photos"];
    unit.numberOfRooms = [dictionary[@"property"][@"bedrooms"]integerValue];
    unit.price = dictionary[@"listPrice"];
    unit.unitDescription = dictionary[@"remarks"];
    unit.area = [dictionary[@"property"][@"area"]integerValue];
    unit.latitude = dictionary[@"geo"][@"lat"];
    unit.longitude = dictionary[@"geo"][@"lng"];
    unit.address = dictionary[@"address"][@"full"];
    
    
    
    NSURL *imageUrl = [NSURL URLWithString:dictionary[@"photos"][0]];
    if ([NSURL URLWithString:dictionary[@"photos"][0]] == nil) {
        NSLog(@"URL is nil");
    }
    else {
        NSLog(@"Image %@", [NSURL URLWithString:dictionary[@"photos"][0]]);
    }
    //   Blocks processing on the thread this runs on (VERY SLOW)
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    unit.photo = [UIImage imageWithData:imageData];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        
        unit.photo = image;
    }];
    [task resume];

    
    
    return unit;
}

- (CLLocationCoordinate2D) coordinate {
    return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
}
@end

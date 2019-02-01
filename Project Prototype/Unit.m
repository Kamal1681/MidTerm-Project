//
//  Unit.m
//  Project Prototype
//
//  Created by Kamal Maged, Van Luu, Paul Uvarov on 2019-01-29.
//  Copyright © 2019 Kamal Maged, Van Luu, Paul Uvarov. All rights reserved.
//

#import "Unit.h"

@interface Unit ()
@property (nonatomic,strong) NSURL *imageUrl;
@property (strong, nonatomic) UIImage * photo; // photo, that appears in the cell
@end

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
    unit.latitude = dictionary[@"geo"][@"lat"];
    unit.longitude = dictionary[@"geo"][@"lng"];
    unit.address = dictionary[@"address"][@"full"];
    unit.additionalFeatures = dictionary[@"additinalRooms"];
    unit.exteriorFeatures = dictionary[@"exteriorFeatures"];
    
    
    
    unit.imageUrl = [NSURL URLWithString:dictionary[@"photos"][0]];
//    if (!imageUrl) {
//        NSLog(@"URL is nil");
//    }
//    else {
//        NSLog(@"Image %@", imageUrl);
//    }
//    //   Blocks processing on the thread this runs on (VERY SLOW)
//    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
//    unit.photo = [UIImage imageWithData:imageData];
    
    return unit;
}

- (void)loadImage:(void (^)(UIImage*))complete {
    if (self.photo) {
        complete(self.photo);
    } else {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageUrl];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage *image = [UIImage imageWithData:data];
            
            self.photo = image;
            [NSOperationQueue.mainQueue addOperationWithBlock:^{
                complete(self.photo);
            }];
        }];
        [task resume];
    }
}

- (CLLocationCoordinate2D) coordinate {
    return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
}

- (NSString *)title {
    return self.address;
}

-(NSString*)subtitle {
    return self.city;
}

@end

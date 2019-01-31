//
//  Unit.h
//  Project Prototype
//
//  Created by Kamal Maged on 2019-01-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Unit : NSObject
@property (strong, nonatomic) NSString * city;//address.city
@property (strong, nonatomic) NSArray * photos;
@property (nonatomic) NSUInteger  numberOfRooms; //property.bedrooms
@property (strong, nonatomic) NSNumber * price;//listprice
@property (strong, nonatomic) NSString * unitDescription; //remarks?
@property (nonatomic) NSUInteger area; //property.area
@property (strong, nonatomic) NSNumber * latitude; //geo.lat
@property (strong, nonatomic) NSNumber * longitude; //geo.lng
@property (strong, nonatomic) NSNumber * address; //address.full

+ (Unit *)fromJsonDictionary:(NSMutableDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END

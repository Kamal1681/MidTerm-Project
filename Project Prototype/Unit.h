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
@property (strong, nonatomic) NSString * city;
@property (nonatomic) NSUInteger  numberOfRooms;
@property (strong, nonatomic) NSNumber * price;
@property (strong, nonatomic) NSString * unitDescription;
- (instancetype)initWithUnitDescription: (NSString *) unitDescription City: (NSString *) city NumberOfRooms: (NSUInteger) numberOfRooms andPrice: (NSNumber *) price;
@end

NS_ASSUME_NONNULL_END

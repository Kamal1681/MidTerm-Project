//
//  Unit.h
//  Project Prototype
//
//  Created by Kamal Maged, Van Luu, Paul Uvarov on 2019-01-29.
//  Copyright © 2019 Kamal Maged, Van Luu, Paul Uvarov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Unit : NSObject<MKAnnotation>
@property (strong, nonatomic) NSString * city;//address.city
@property (strong, nonatomic) NSArray * photos;
@property (nonatomic) NSUInteger  numberOfRooms; //property.bedrooms
@property (strong, nonatomic) NSNumber * price;//listprice
@property (strong, nonatomic) NSString * unitDescription; //remarks?
@property (nonatomic) NSUInteger area; //property.area
@property (strong, nonatomic) NSNumber * latitude; //geo.lat
@property (strong, nonatomic) NSNumber * longitude; //geo.lng
@property (strong, nonatomic) NSString * address; //address.full
@property (strong, nonatomic) NSString * additionalFeatures; // additionalRooms
@property (strong, nonatomic) NSString * exteriorFeatures; // exteriorFeatures
@property (strong, nonatomic) NSString * agentName;
@property (nonatomic) NSString * agentContact;
@property (strong, nonatomic) NSString * agentID;


+ (Unit *)fromJsonDictionary:(NSMutableDictionary *)dictionary;
- (void)loadImage:(void (^)(UIImage* photo))complete;

@end

NS_ASSUME_NONNULL_END

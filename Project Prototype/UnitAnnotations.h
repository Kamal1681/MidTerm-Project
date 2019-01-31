//
//  UnitAnnotations.h
//  Project Prototype
//
//  Created by Van Luu on 2019-01-31.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnitAnnotations : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
- (instancetype)initWithCoordinate: (CLLocationCoordinate2D)coordinate andTitle:(NSString*)title;

@end

NS_ASSUME_NONNULL_END

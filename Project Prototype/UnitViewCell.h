//
//  UnitViewCell.h
//  Project Prototype
//
//  Created by Kamal Maged, Van Luu, Paul Uvarov on 2019-01-29.
//  Copyright © 2019 Kamal Maged, Van Luu, Paul Uvarov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Unit.h"

NS_ASSUME_NONNULL_BEGIN

@interface UnitViewCell : UITableViewCell
@property (weak, nonatomic) Unit *unitListing;
@property(weak, nonatomic) Unit *unit;

@end

NS_ASSUME_NONNULL_END

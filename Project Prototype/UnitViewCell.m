//
//  UnitViewCell.m
//  Project Prototype
//
//  Created by Kamal Maged on 2019-01-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "UnitViewCell.h"

@interface UnitViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *listingImageView;
@property (weak, nonatomic) IBOutlet UILabel *listingPriceLabel;


@end

@implementation UnitViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

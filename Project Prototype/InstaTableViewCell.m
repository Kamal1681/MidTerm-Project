//
//  InstaTableViewCell.m
//  Project Prototype
//
//  Created by Pavel on 2019-01-31.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "InstaTableViewCell.h"
#import "InstaTableViewCell.h"

@interface InstaTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation InstaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

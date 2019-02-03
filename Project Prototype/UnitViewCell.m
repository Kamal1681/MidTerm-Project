//
//  UnitViewCell.m
//  Project Prototype
//
//  Created by Kamal Maged, Van Luu, Paul Uvarov on 2019-01-29.
//  Copyright © 2019 Kamal Maged, Van Luu, Paul Uvarov. All rights reserved.
//

#import "UnitViewCell.h"

@interface UnitViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *listingImageView;
@property (weak, nonatomic) IBOutlet UILabel *listingPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listingNumberOfBedrooms;


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


- (void)setUnit:(Unit *) unit {
    _unit = unit;
    
    //Set Photos in cell
    [unit loadImage:^(UIImage * photo) {
        if (self.unit == unit) {
            self.listingImageView.image = photo;
        }
    }];

    

    self.listingPriceLabel.text = [NSString stringWithFormat:@"Price is %@", unit.price];
   

    
    // Set Price in cell and Create format for the price
    NSNumberFormatter *indCurrencyFormatter = [[NSNumberFormatter alloc] init];
    [indCurrencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [indCurrencyFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *formattedString =  [indCurrencyFormatter stringFromNumber: unit.price];
    formattedString = [formattedString substringToIndex:[formattedString length]-3]; // cut .00 from the string
    self.listingPriceLabel.text = [NSString stringWithFormat:@"%@", formattedString];
   
    
    // Set number of bedrooms in cell
    self.listingNumberOfBedrooms.text = [NSString stringWithFormat:@"%lu", unit.numberOfRooms];

}



@end

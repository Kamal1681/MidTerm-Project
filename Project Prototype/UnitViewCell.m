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
@property (weak, nonatomic) IBOutlet UILabel *listingNumberOfBedrooms;


@end

@implementation UnitViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
      [self addObserver:self forKeyPath:@"self.unit.photo" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:nil];}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"self.unit.photo"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"self.unit.photo"]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.listingImageView.image = self.unit.photo;
        }];
    }
}

- (void)setUnit:(Unit *) unit {
    _unit = unit;
    
    //Set Photos in cell
    self.listingImageView.image = unit.photo;

    self.listingPriceLabel.text = [NSString stringWithFormat:@"Price is %@", unit.listingPrice];
    NSLog(@"Price is %@", unit.listingPrice);

    
    // Set Price in cell and Create format for the price
    NSNumberFormatter *indCurrencyFormatter = [[NSNumberFormatter alloc] init];
    [indCurrencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [indCurrencyFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *formattedString =  [indCurrencyFormatter stringFromNumber: unit.listingPrice];
    formattedString = [formattedString substringToIndex:[formattedString length]-3]; // cut .00 from the string
    self.listingPriceLabel.text = [NSString stringWithFormat:@"%@", formattedString];
    NSLog(@"Price is %@", unit.listingPrice);
    
    // Set number of bedrooms in cell
    self.listingNumberOfBedrooms.text = [NSString stringWithFormat:@"%lu", unit.numberOfRooms];

}

@end

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

    
//    [self addObserver:self forKeyPath:@"self.unit.photo" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:nil];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
//    [self removeObserver:self forKeyPath:@"self.unit.photo"];
}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"self.unit.photo"]) {
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            self.photo.image = self.unit.photo;
//        }];
//    }
//}

- (void)setUnit:(Unit *) unit {
    _unit = unit;
    
    //Set Photos in cell
//    self.photo.image = unit.photo;
    [unit loadImage:^(UIImage * _Nonnull photo) {
        if (self.unit == unit) {
            self.photo.image = photo;
        }
    }];
    
    
    self.priceLabel.text = [NSString stringWithFormat:@"Price is %@", unit.price];
    NSLog(@"Price is %@", unit.price);
    
    
    // Set Price in cell and Create format for the price
    NSNumberFormatter *indCurrencyFormatter = [[NSNumberFormatter alloc] init];
    [indCurrencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [indCurrencyFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *formattedString =  [indCurrencyFormatter stringFromNumber: unit.price];
    formattedString = [formattedString substringToIndex:[formattedString length]-3]; // cut .00 from the string
    self.priceLabel.text = [NSString stringWithFormat:@"%@", formattedString];
    NSLog(@"Price is %@", unit.price);
    
}

@end

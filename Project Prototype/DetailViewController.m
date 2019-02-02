//
//  DetailViewController.m
//  Project Prototype
//
//  Created by Kamal Maged, Van Luu, Paul Uvarov on 2019-01-29.
//  Copyright © 2019 Kamal Maged, Van Luu, Paul Uvarov. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UIScrollViewDelegate>

@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.cityLabel.text = self.unitObject.city;
    self.unitDescriptionLabel.text = self.unitObject.unitDescription;

    
    NSNumberFormatter *indCurrencyFormatter = [[NSNumberFormatter alloc] init];
    [indCurrencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [indCurrencyFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *formattedString =  [indCurrencyFormatter stringFromNumber: self.unitObject.price];
    formattedString = [formattedString substringToIndex:[formattedString length]-3]; // cut .00 from the string
    self.listingPriceLabel.text = [NSString stringWithFormat:@"%@", formattedString];

    
    self.bedRoomsLabel.text = [NSString stringWithFormat:@"Bedrooms: %lu", self.unitObject.numberOfRooms];
    self.areaLabel.text = [NSString stringWithFormat:@"Surface Area: %lu", self.unitObject.area];
    self.additionalFeaturesLabel.text = self.unitObject.additionalFeatures;
    self.exteriorFeaturesLabel.text = self.unitObject.exteriorFeatures;
    self.photosArray = [[NSMutableArray alloc]initWithCapacity:self.unitObject.photos.count];
    self.imageViewArray = [[NSMutableArray alloc]initWithCapacity:self.unitObject.photos.count];
    [self setUpScrollView];
}
- (void)setUpScrollView {
    CGRect scrollViewBounds = self.scrollView.bounds;
    
    self.scrollView.contentSize = CGSizeMake(scrollViewBounds.size.width * self.unitObject.photos.count, scrollViewBounds.size.height);
    
    for (int i = 0; i < self.unitObject.photos.count; i++) {
        
        NSURL * imageUrl = [NSURL URLWithString:self.unitObject.photos[i]];
        if (!imageUrl) {
            NSLog(@"URL is nil");
        }
        else {
            NSLog(@"Image %@", imageUrl);
        }
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        [self.photosArray addObject:[UIImage imageWithData:imageData]];
        UIImage * image = self.photosArray[i];
        UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
        [self.imageViewArray addObject:imageView];
    }
    
    CGFloat xOffset = 0;
    for (UIImageView *imageView in self.imageViewArray) {
        [self.scrollView addSubview:imageView];
        
        CGRect imageFrame = CGRectMake(imageView.frame.origin.x + xOffset,
                                       imageView.frame.origin.y,
                                       (self.scrollView.contentSize.width / self.unitObject.photos.count),
                                       imageView.frame.size.height);
        [imageView setFrame:(imageFrame)];
        
        xOffset += CGRectGetWidth(imageView.frame);
    }
}
    
    


- (IBAction)pageChanged:(id)sender {
    NSUInteger currentPage = self.pageControl.currentPage;
    CGFloat x = currentPage * (self.scrollView.contentSize.width / self.unitObject.photos.count);
    
    [self.scrollView scrollRectToVisible:CGRectMake(x, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    int currentPage = scrollView.contentOffset.x / (self.scrollView.contentSize.width / self.unitObject.photos.count);
    
    self.pageControl.currentPage = currentPage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

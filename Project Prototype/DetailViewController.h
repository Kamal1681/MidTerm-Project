//
//  DetailViewController.h
//  Project Prototype
//
//  Created by Kamal Maged on 2019-01-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Unit.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property(weak, nonatomic) IBOutlet UIScrollView * scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(weak, nonatomic) IBOutlet UIImageView * photo;

@property(weak, nonatomic) IBOutlet UILabel * cityLabel;
@property (weak, nonatomic) IBOutlet UILabel * unitDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel * listingPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel * bedRoomsLabel;
@property (weak, nonatomic) IBOutlet UILabel * areaLabel;
@property (weak, nonatomic) IBOutlet UILabel * additionalFeaturesLabel;
@property (weak, nonatomic) IBOutlet UILabel * exteriorFeaturesLabel;

@property (weak, nonatomic) Unit * unitObject;
@property (strong, nonatomic) NSMutableArray <NSURL *> * imageUrlArray;
@property (strong, nonatomic) NSMutableArray <UIImage *> * photosArray;
@property (strong, nonatomic) NSMutableArray <UIImageView *> * imageViewArray;

@end

NS_ASSUME_NONNULL_END

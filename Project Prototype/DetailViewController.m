//
//  DetailViewController.m
//  Project Prototype
//
//  Created by Kamal Maged, Van Luu, Paul Uvarov on 2019-01-29.
//  Copyright © 2019 Kamal Maged, Van Luu, Paul Uvarov. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.cityLabel.text = self.unitObject.city;
    self.unitDescriptionLabel.text = self.unitObject.unitDescription;
    self.listingPriceLabel.text = [NSString stringWithFormat:@"%@", self.unitObject.listingPrice];
    self.bedRoomsLabel.text = [NSString stringWithFormat:@"%lu", self.unitObject.numberOfRooms];
    self.areaLabel.text = [NSString stringWithFormat:@"%lu", self.unitObject.area];
    self.additionalFeaturesLabel.text = self.unitObject.additionalFeatures;
    self.exteriorFeaturesLabel.text = self.unitObject.exteriorFeatures;
    
    [self setUpScrollView];
    
  

    //   Blocks processing on the thread this runs on (VERY SLOW)

    
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
        [self.imageUrlArray addObject:imageUrl];
        
        NSData *imageData = [NSData dataWithContentsOfURL:self.imageUrlArray[i]];
        
        self.photo.image = [UIImage imageWithData:imageData];
        [self.scrollView addSubview:self.photo];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage *image = [UIImage imageWithData:data];
            
            self.photosArray[i] = image;
        }];
        [task resume];
        
        
    }
}

- (IBAction)pageChanged:(id)sender {
    NSUInteger currentPage = self.pageControl.currentPage;
    CGFloat x = currentPage * 320;
    
    [self.scrollView scrollRectToVisible:CGRectMake(x, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    int currentPage = scrollView.contentOffset.x / 320;
    
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

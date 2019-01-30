//
//  SearchViewController.m
//  Project Prototype
//
//  Created by Kamal Maged on 2019-01-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "SearchViewController.h"
#import "UnitViewCell.h"

@interface SearchViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSArray *unitListings;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.unitListings.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UnitViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"listingCell" forIndexPath:indexPath];
    
    return cell;
}



@end

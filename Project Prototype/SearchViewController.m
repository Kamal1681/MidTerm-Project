//
//  SearchViewController.m
//  Project Prototype
//
//  Created by Kamal Maged on 2019-01-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "SearchViewController.h"
#import "UnitViewCell.h"


@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *unitArray;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", @"simplyrets", @"simplyrets"];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
    
    NSLog(@"%@", self.searchQuery);
    
    NSURL *url = [NSURL URLWithString:self.searchQuery];
    
    //Authorization with login and password
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    // NSURL * url = [NSURL URLWithString:@"https://api.simplyrets.com/properties?limit=500&lastId=0"];
    //NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionTask * task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData * _Nullable data,
                                                        NSURLResponse * _Nullable response,
                                                        NSError * _Nullable error) {
                                        NSError *jsonError;
                                        NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:0
                                                                                          error:&jsonError];
                                        
                                        
                                        
                                        NSMutableArray * units = [NSMutableArray new];
                                        for (NSMutableDictionary * unitDictionary in json) {
                                            Unit * unitSample = [Unit fromJsonDictionary:unitDictionary];
                                            [units addObject:unitSample];
                                        }
                                        
                                        self.unitArray = units;
                                        
                                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                            [self.tableView reloadData];
                                        }];
                                    }];
    
    [task resume];
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.unitArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UnitViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"listingCell" forIndexPath:indexPath];
    
    return cell;
}



//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    <#code#>
//}
//
//- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    <#code#>
//}



@end

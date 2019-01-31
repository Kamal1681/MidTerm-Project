//
//  SearchViewController.m
//  Project Prototype
//
//  Created by Kamal Maged on 2019-01-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "SearchViewController.h"
#import "UnitViewCell.h"
#import <MapKit/MapKit.h>
#import "UnitAnnotations.h"
#import "Unit.h"



@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *unitArray;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) Unit *myUnit;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myUnit = [[Unit alloc] init];

    //Set up location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 20;
    self.locationManager.delegate = self;
    
    [self.locationManager requestWhenInUseAuthorization];
    
    //setting up mapview
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.mapType = MKMapTypeStandard;
    
    [self.mapView registerClass:[MKMarkerAnnotationView class] forAnnotationViewWithReuseIdentifier:@"myAnnotation"];
    
    
    //set up the unit annotations
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(self.myUnit.latitude.doubleValue, self.myUnit.longitude.doubleValue);
    UnitAnnotations *annotation = [[UnitAnnotations alloc]initWithCoordinate:coord andTitle:self.myUnit.address];
    [self.mapView addAnnotation:annotation];

    
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    //Parsing Json File
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
                                        
                                        [self loadAnnotations];
                                        
                                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                            [self.tableView reloadData];
                                        }];
                                    }];
    
    [task resume];
}

- (void)loadAnnotations {
    for (Unit *unit in self.unitArray) {
        // Create an annotation and add it to the map
        [self.mapView addAnnotation:unit];
        //make uit conform to mkanno prot/
    }
}





#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:UnitAnnotations.class]) {
        MKMarkerAnnotationView *mark = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation" forAnnotation:annotation];
        mark.tintColor = [UIColor blueColor];
        mark.titleVisibility = MKFeatureVisibilityVisible;
        mark.animatesWhenAdded = YES;
        
        return mark;
    }
    return nil;
}



#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.unitArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UnitViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"listingCell" forIndexPath:indexPath];
    

    cell.unit = self.unitArray[indexPath.row];

    
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

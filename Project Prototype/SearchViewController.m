//
//  SearchViewController.m
//  Project Prototype
//
//  Created by Kamal Maged, Van Luu, Paul Uvarov on 2019-01-29.
//  Copyright © 2019 Kamal Maged, Van Luu, Paul Uvarov. All rights reserved.
//

#import "SearchViewController.h"
#import "UnitViewCell.h"
#import <MapKit/MapKit.h>
#import "UnitAnnotations.h"
#import "Unit.h"
#import "DetailViewController.h"
#import "InstaViewController.h"



@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *unitArray;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) Unit *myUnit;



@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    //setting out current location
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc]init];
    myAnnotation.coordinate = CLLocationCoordinate2DMake(29.9228365, -95.4722851);
    [myAnnotation setTitle:@"Your Current Location"];
    [myAnnotation setSubtitle:@"Where we currently are"];
    [self.mapView addAnnotation: myAnnotation];
    CLLocationCoordinate2D zoomToLocation = CLLocationCoordinate2DMake(29.9228365, -95.4722851);
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomToLocation, 500, 500);
    [self.mapView setRegion:adjustedRegion];
    
    
    
    //set up the unit annotations
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(self.myUnit.latitude.doubleValue, self.myUnit.longitude.doubleValue);
    UnitAnnotations *annotation = [[UnitAnnotations alloc]initWithCoordinate:coord andTitle:self.myUnit.address];
    [annotation setTitle:@"my Title"];
    [self.mapView addAnnotation:annotation];
    
    
    
    self.unitArray = [[NSMutableArray alloc] init];
    
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    
//    int i = 0;
//
//    if (i == 0) {
    
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
                                        
                                        
                                        if (self.searchIndex == 0) {
                                            NSMutableArray * units = [NSMutableArray new];

                                            for (NSMutableDictionary * unitDictionary in json) {
                                                Unit * unitSample = [Unit fromJsonDictionary:unitDictionary];
                                                [units addObject:unitSample];
                                            }
                                            self.searchIndex = 1;
                                            [self.unitArray removeAllObjects];
                                            [self.unitArray addObjectsFromArray:units];
                                        }
                                                                              
                                        [self loadAnnotations];
                                        
                                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                            [self.tableView reloadData];
                                            [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedImageDownload" object:nil];
//                                            InstaViewController *dvc = [[InstaViewController alloc] init];
//                                            dvc.unitArray = self.unitArray;
                                        }];
                                    }];
    
    [task resume];
        
//        i += 1;
//
//    }
}

- (void)loadAnnotations {
    for (Unit *unit in self.unitArray) {
        // Create an annotation and add it to the map
        [self.mapView addAnnotation:unit];
        //make uit conform to mkanno prot/
    }
}








#pragma mark - MKMapViewDelegate


- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass: [Unit class]])
    {
        MKAnnotationView *anyView;
        //////// VIEW
        anyView = [mapView dequeueReusableAnnotationViewWithIdentifier: @"pinId"];
        if (!anyView)
        {
            anyView = [[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"pinId"];
            anyView.canShowCallout = YES;
            anyView.image = [UIImage imageNamed:@"pin.png"];
            anyView.calloutOffset = CGPointMake(0, -32);
//            UIButton* rightButton = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
            
//            [rightButton addTarget:self
//                            action:@selector(myTempAction)
//                  forControlEvents:UIControlEventTouchUpInside];
//
//
//            anyView.rightCalloutAccessoryView = rightButton;
            
//            anyView.leftCalloutAccessoryView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//            [(UIImageView*)anyView.leftCalloutAccessoryView setImage:self.myUnit.photo];
//
            // Add an image to the left callout.
//            UIImageView *iconView = [[UIImageView alloc] initWithImage:self.myUnit.photo];
//            [iconView setFrame:CGRectMake(0, 0, 0, 0)];
//            anyView.leftCalloutAccessoryView = iconView;
        }
        else
        {
            anyView.annotation = annotation;
        }
        return anyView;
    }
    
    return nil;
}


//-(void)myTempAction
//{
//    NSLog(@"View more details by selecting this house below");
//}



    
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    if ([annotation isKindOfClass:UnitAnnotations.class]) {
//        MKMarkerAnnotationView *mark = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation" forAnnotation:annotation];
//        mark.tintColor = [UIColor blueColor];
//        mark.titleVisibility = MKFeatureVisibilityVisible;
//        mark.animatesWhenAdded = YES;
//
//        return mark;
//    }
//    return nil;
//}
//
//

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.unitArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UnitViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"listingCell" forIndexPath:indexPath];
    cell.unit = self.unitArray[indexPath.row];
    
    return cell;

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Detail View"]) {
        
        DetailViewController * detailView = segue.destinationViewController;
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        Unit * unit = self.unitArray[indexPath.row];
        detailView.unitObject = unit;
    }
    else if ([segue.identifier isEqualToString:@"instaViewSegue"]) {
        InstaViewController *dvc = segue.destinationViewController;
        dvc.unitArray = self.unitArray;
    }
}


//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    <#code#>
//}
//
//- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    <#code#>
//}



@end

//
//  ViewController.m
//  Project Prototype
//
//  Created by Kamal Maged on 2019-01-29.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "ViewController.h"
#import "Unit.h"
@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *price;
@property (weak, nonatomic) IBOutlet UIPickerView *rooms;
@property (strong, nonatomic) NSArray * unitArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated {
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", @"simplyrets", @"simplyrets"];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
    
    NSURL *url = [NSURL URLWithString:@"https://api.simplyrets.com/properties?limit=20&lastId=0"];
    
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
                                        //NSDictionary * units = json[0];

                                        
                                        NSMutableArray * units = [NSMutableArray new];
                                        for (NSMutableDictionary * unitDictionary in json[0]) {
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

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}



@end

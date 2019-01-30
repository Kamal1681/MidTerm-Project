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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated {
    
    NSURL * url = [NSURL URLWithString:@"https://api.simplyrets.com/properties?limit=500&lastId=0"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionTask * task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData * _Nullable data,
                                                        NSURLResponse * _Nullable response,
                                                        NSError * _Nullable error) {
                                        NSError *jsonError;
                                        NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                             options:0
                                                                                               error:&jsonError];
                                        NSDictionary * units = json[0];

                                        
                                        NSMutableArray * unitsArray = [NSMutableArray new];
                                        for (NSDictionary * unitDictionary in unitsArray) {
                                            Unit * unit = [Unit fromJsonDictionary:<#(nonnull NSMutableDictionary *)#>]
                                        }
                                        
                                    }];
     }

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}



@end

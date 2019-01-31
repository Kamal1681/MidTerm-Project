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
@property (weak, nonatomic) IBOutlet UIPickerView *city;
@property (weak, nonatomic) IBOutlet UIPickerView *minPrice;
@property (weak, nonatomic) IBOutlet UIPickerView *maxPrice;
@property (weak, nonatomic) IBOutlet UIPickerView *rooms;

@property NSArray *citiesArray;
@property NSArray *pricesArray;
@property NSArray *roomsArray;

@property (strong, nonatomic) NSString * searchQuery;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.citiesArray = @[@"Cypress", @"Houston", @"Katy", @"Oak Ridge",  @"The Woodlands", @"Tomball"];
    self.pricesArray = @[@"100000", @"150000", @"200000", @"250000", @"300000", @"350000", @"400000", @"450000", @"500000", @"550000", @"600000", @"650000", @"700000", @"750000", @"800000", @"850000", @"900000", @"950000", @"1000000", @"1500000"];
    self.roomsArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
}


- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.city) {
        return self.citiesArray.count;
    } else if (pickerView == self.minPrice || pickerView == self.maxPrice) {
        return self.pricesArray.count;
    } else if (pickerView == self.rooms)
        return self.roomsArray.count;
    else {
        return 5;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    if (pickerView == self.city) {
            return self.citiesArray[row];
    }
    else if (pickerView == self.minPrice || pickerView == self.maxPrice) {
        return self.pricesArray[row];
    }
    else if (pickerView == self.rooms) {
        return self.roomsArray[row];
    }
    else {
        return @"Not found";
    }

}


@end

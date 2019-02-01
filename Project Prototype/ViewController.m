//
//  ViewController.m
//  Project Prototype
//
//  Created by Kamal Maged, Van Luu, Paul Uvarov on 2019-01-29.
//  Copyright © 2019 Kamal Maged, Van Luu, Paul Uvarov. All rights reserved.
//

#import "ViewController.h"
#import "Unit.h"
#import "SearchViewController.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *city;
@property (weak, nonatomic) IBOutlet UIPickerView *minPrice;
@property (weak, nonatomic) IBOutlet UIPickerView *maxPrice;
@property (weak, nonatomic) IBOutlet UIPickerView *rooms;

@property NSArray *citiesArray;
@property NSMutableArray *pricesArray;
@property NSArray *roomsArray;

@property NSString *pickedCity;
@property NSString *pickedMinPrice;
@property NSString *pickedMaxPrice;
@property NSString *pickedrooms;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.citiesArray = @[@"All cities", @"Cypress", @"Houston", @"Katy", @"Oak Ridge",  @"The Woodlands", @"Tomball"];
    
    self.pricesArray = @[].mutableCopy;
    
    for (int i = 1; i < 150; i++) {
        int price = i * 100000;
        NSString *strPrice = [NSString stringWithFormat:@"%d", price];
        [self.pricesArray addObject:strPrice];
    }

    self.roomsArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    
    self.pickedCity = self.citiesArray[0];
    self.pickedMinPrice = self.pricesArray[0];
    self.pickedMaxPrice = self.pricesArray.lastObject;
    self.pickedrooms = self.roomsArray[0];

    [self.maxPrice selectRow: (self.pricesArray.count - 1) inComponent:0 animated:YES];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"searchSegue"]) {
        
        SearchViewController *dvc = [segue destinationViewController];
        if ([self.pickedCity isEqualToString:self.citiesArray[0]]) {
            dvc.searchQuery = [NSString stringWithFormat: @"https://api.simplyrets.com/properties?limit=500&lastId=0&minprice=%@&maxprice=%@&minbeds=%@&count=true", self.pickedMinPrice, self.pickedMaxPrice, self.pickedrooms];
        } else {
            dvc.searchQuery = [NSString stringWithFormat: @"https://api.simplyrets.com/properties?limit=500&lastId=0&minprice=%@&maxprice=%@&minbeds=%@&cities=%@&count=true", self.pickedMinPrice, self.pickedMaxPrice, self.pickedrooms, [self.pickedCity stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
        }
        
        dvc.searchIndex = 0;
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.city) {
        self.pickedCity = self.citiesArray[row];
    }
    else if (pickerView == self.minPrice) {
        self.pickedMinPrice = self.pricesArray[row];
    }
    else if (pickerView == self.maxPrice) {
        self.pickedMaxPrice = self.pricesArray[row];
    }
    else if (pickerView == self.rooms) {
        self.pickedrooms = self.roomsArray[row];
    }
    NSLog(@"Picked %@, %@, %@, %@", self.pickedCity, self.pickedMinPrice, self.pickedMaxPrice, self.pickedrooms);
    
}

@end

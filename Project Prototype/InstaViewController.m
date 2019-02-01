//
//  InstaViewController.m
//  Project Prototype
//
//  Created by Pavel on 2019-01-31.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "InstaViewController.h"
#import "InstaTableViewCell.h"

@interface InstaViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *instaTableView;

@end

@implementation InstaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.unitArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InstaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"instaTableViewCell" forIndexPath:indexPath];
    cell.unit = self.unitArray[indexPath.row];
    
    return cell;
    
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

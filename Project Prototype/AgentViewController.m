//
//  AgentViewController.m
//  Project Prototype
//
//  Created by Kamal Maged on 2019-02-02.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

#import "AgentViewController.h"

@interface AgentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *agentName;
@property (weak, nonatomic) IBOutlet UILabel *agentContact;
@property (weak, nonatomic) IBOutlet UILabel *agentID;

@end

@implementation AgentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.01];

    // Do any additional setup after loading the view.

    
}


- (void)didMoveToParentViewController:(UIViewController *)parent {
    
    [super didMoveToParentViewController:parent];
    self.agentName.text = self.unitObject.agentName;
    self.agentID.text = [@"ID: " stringByAppendingString:self.unitObject.agentID];
    self.agentContact.text = @"647-1234567";
    
}

- (IBAction)close:(id)sender {
    [self.view removeFromSuperview];
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

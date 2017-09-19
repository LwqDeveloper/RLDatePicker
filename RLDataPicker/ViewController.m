//
//  ViewController.m
//  RLDataPicker
//
//  Created by mbp on 2017/9/18.
//  Copyright © 2017年 mbp. All rights reserved.
//

#import "ViewController.h"
#import "RLDataPicker.h"
#import "RLDateHelper.h"

@interface ViewController ()

@property (nonatomic, strong) RLDateHelper *dateHelper;

@property (strong, nonatomic) UILabel *dateLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.dateHelper = [[RLDateHelper alloc] init];
    
    __weak typeof(self) weakSelf = self;
    [RLDataPicker showWithDefaultDate:[NSDate dateWithTimeIntervalSinceNow:180*24*60*60] minDate:[NSDate date] maxDate:[NSDate dateWithTimeIntervalSinceNow:365*24*60*60] completion:^(NSDate *date) {
        weakSelf.dateLabel.text = [weakSelf.dateHelper stringFromDate:date format:@"yyyy-MM-dd"];
    }];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height /2., self.view.frame.size.width, 40)];
    self.dateLabel.textColor = [UIColor blackColor];
    [self.dateLabel setTextAlignment:NSTextAlignmentCenter];    
    [self.view addSubview:self.dateLabel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

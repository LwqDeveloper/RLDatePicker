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
    RLDataPicker *datePicker = [[RLDataPicker alloc] initWithFrame:CGRectMake(20, 120, 320, 105) maxDate:[NSDate dateWithTimeIntervalSinceNow:365*24*60*60] minDate:[NSDate date] completion:^(NSDate *date) {
        weakSelf.dateLabel.text = [weakSelf.dateHelper stringFromDate:date format:@"yyyy-MM-dd"];
    }];
    datePicker.defaultDate = [NSDate dateWithTimeIntervalSinceNow:180*24*60*60];
    [self.view addSubview:datePicker];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(datePicker.frame) /2., self.view.frame.size.width, 40)];
    self.dateLabel.textColor = [UIColor blackColor];
    //下方显示时间的label
    [self.dateLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:self.dateLabel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

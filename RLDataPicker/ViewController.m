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

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) NSDate *defaultDate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height /2., self.view.frame.size.width, 40)];
    self.dateLabel.textColor = [UIColor blackColor];
    [self.dateLabel setTextAlignment:NSTextAlignmentCenter];    
    [self.view addSubview:self.dateLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(self.view.bounds.size.width /2. -50, CGRectGetMaxY(self.dateLabel.frame) +10, 100, 30);
    [button addTarget:self action:@selector(buttonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonTap
{
    self.dateHelper = [[RLDateHelper alloc] init];
    self.defaultDate = [self.dateHelper minSelectAge];
    __weak typeof(self) weakSelf = self;
    [RLDataPicker showWithDefaultDate:self.defaultDate minDate:[self.dateHelper maxSelectAge] maxDate:[self.dateHelper minSelectAge] completion:^(NSDate *date) {
        weakSelf.defaultDate = date;
        weakSelf.dateLabel.text = [weakSelf.dateHelper stringFromDate:date format:@"yyyy-MM-dd"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

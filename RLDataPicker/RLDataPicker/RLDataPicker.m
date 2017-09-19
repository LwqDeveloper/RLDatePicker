//
//  RLDataPicker.m
//  RLDataPicker
//
//  Created by mbp on 2017/9/18.
//  Copyright © 2017年 mbp. All rights reserved.
//

#import "RLDataPicker.h"
#import "RLDateHelper.h"

#define RLCOLOR(hexValue) [UIColor colorWithRed:((float)((hexValue & 0x00FF0000) >> 16)) / 255.0 green:((float)((hexValue & 0x0000FF00) >> 8)) / 255.0 blue:((float)(hexValue & 0x000000FF)) / 255.0 alpha:((float)((hexValue & 0xFF000000) >> 24)) / 255.0]

@interface RLDataPicker () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, assign) CGFloat screen_width;
@property (nonatomic, assign) CGFloat screen_height;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;

@property (nonatomic, strong) RLDateHelper *dateHelper;
@property (nonatomic, copy  ) void(^completion)(NSDate *date);
@property (nonatomic, strong) NSDate *defaultDate;

@end

@implementation RLDataPicker

- (instancetype)initWithFrame:(CGRect)frame maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate completion:(void(^)(NSDate *))completion
{
    if (self = [super initWithFrame:frame]) {
        self.screen_width = frame.size.width;
        self.screen_height = frame.size.height;
        
        self.minDate = minDate;
        self.maxDate = maxDate;
        
        self.dateHelper = [[RLDateHelper alloc] init];
        self.dateHelper.minDate = minDate;
        self.dateHelper.maxDate = maxDate;
        
        self.completion = completion;
        [self commonInit];
    }
    return self;
}

+ (instancetype)showWithDefaultDate:(NSDate *)defaultDate minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate completion:(void(^)(NSDate *))completion
{
    RLDataPicker *datePicker = [[RLDataPicker alloc] initWithFrame:[UIScreen mainScreen].bounds maxDate:maxDate minDate:minDate completion:^(NSDate *date) {
        completion(date);
    }];
    if (defaultDate) {
        datePicker.defaultDate = defaultDate;
    }
    [datePicker rl_showInView:[UIApplication sharedApplication].delegate.window];
    return datePicker;
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit {
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    bgView.userInteractionEnabled = NO;
    [self addSubview:bgView];
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(45, self.screen_height /2. -107.5, self.screen_width -90, 215)];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.layer.cornerRadius = 5;
    centerView.layer.masksToBounds = YES;
    [self addSubview:centerView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, centerView.bounds.size.width -30, 20)];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = @"年龄";
    titleLabel.textColor = RLCOLOR(0xff333333);
    [centerView addSubview:titleLabel];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(15, 40, centerView.bounds.size.width -30, 120)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [centerView addSubview:self.pickerView];
    
    CGFloat line0Width = self.pickerView.bounds.size.width *5 /11.;
    CGFloat line1Width = self.pickerView.bounds.size.width *3 /11.;

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(line0Width /2. -41, (self.pickerView.bounds.size.height-35)/2, 82, 1)];
    line.backgroundColor = RLCOLOR(0xff10caa5);
    [self.pickerView addSubview:line];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(line0Width /2. -41, (self.pickerView.bounds.size.height-35)/2+35, 82, 1)];
    line.backgroundColor = RLCOLOR(0xff10caa5);
    [self.pickerView addSubview:line];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(line0Width +line1Width /2. -25.5, (self.pickerView.bounds.size.height-35)/2, 51, 1)];
    line.backgroundColor = RLCOLOR(0xff10caa5);
    [self.pickerView addSubview:line];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(line0Width +line1Width /2. -25.5, (self.pickerView.bounds.size.height-35)/2+35, 51, 1)];
    line.backgroundColor = RLCOLOR(0xff10caa5);
    [self.pickerView addSubview:line];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(line0Width +line1Width *3 /2. -20.5, (self.pickerView.bounds.size.height-35)/2, 51, 1)];
    line.backgroundColor = RLCOLOR(0xff10caa5);
    [self.pickerView addSubview:line];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(line0Width +line1Width *3 /2. -20.5, (self.pickerView.bounds.size.height-35)/2+35, 51, 1)];
    line.backgroundColor = RLCOLOR(0xff10caa5);
    [self.pickerView addSubview:line];
    
    NSArray *titles = @[@"取消",@"确定"];
    for (NSInteger i = 0; i < titles.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 +i;
        button.frame = CGRectMake(centerView.bounds.size.width /2. *i, centerView.bounds.size.height -39, centerView.bounds.size.width /2., 39);
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:RLCOLOR(0xff10caa5) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [centerView addSubview:button];
    }
    
    UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, centerView.bounds.size.height -39, centerView.bounds.size.width, 0.5)];
    hLine.backgroundColor = RLCOLOR(0xffcccccc);
    [centerView addSubview:hLine];
    
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(centerView.bounds.size.width /2. -0.5 /2., centerView.bounds.size.height -39, 0.5, 39)];
    vLine.backgroundColor = RLCOLOR(0xffcccccc);
    [centerView addSubview:vLine];
}

#pragma mark - pickerView dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.dateHelper years];
    } else if (component == 1) {
        NSInteger row0Select = [pickerView selectedRowInComponent:0];
        NSInteger curYear = [self.dateHelper minYear] +row0Select;
        return [self.dateHelper monthsOfYear:[NSString stringWithFormat:@"%@",@(curYear)]];
    } else {
        NSInteger row0Select = [pickerView selectedRowInComponent:0];
        NSInteger curYear = [self.dateHelper minYear] +row0Select;
        NSInteger row1Select = [pickerView selectedRowInComponent:1];
        NSInteger curMonth = row1Select +1;
        return [self.dateHelper daysOfYear:[NSString stringWithFormat:@"%@",@(curYear)] month:[NSString stringWithFormat:@"%@",@(curMonth)]];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    NSArray *widthRate = @[@(5 /11.),@(3 /11.),@(3 /11.)];
    return pickerView.bounds.size.width *[widthRate[component %3] floatValue];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lblDate = [[UILabel alloc] init];
    [lblDate setFont:[UIFont systemFontOfSize:25.0]];
    [lblDate setTextColor:RLCOLOR(0xff333333)];
    lblDate.textAlignment = NSTextAlignmentCenter;

    if (component == 0) {
        lblDate.text = [NSString stringWithFormat:@"%@年",@([self.dateHelper minYear] +row)];
    } else if (component == 1) {
        lblDate.text = [NSString stringWithFormat:@"%@月",@(row +1)];
    } else if (component == 2) {
        lblDate.text = [NSString stringWithFormat:@"%@日",@(row +1)];
    }
    
    for (UIView *speartorView in pickerView.subviews) {
        if (speartorView.frame.size.height < 1) {
            speartorView.hidden = YES;
        }
    }
    
    return lblDate;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    } else if (component == 1) {
        [pickerView reloadComponent:2];
    }
}

- (void)buttonTap:(UIButton *)button
{
    if (button.tag == 101) {
        if (self.completion) {
            self.completion(self.date);
        }
    }
    [self removeFromSuperview];
}

- (NSDate *)date
{
    int year = (int)([self.pickerView selectedRowInComponent:0] +[self.dateHelper minYear]);
    int month = (int)([self.pickerView selectedRowInComponent:1] +1);
    int day = (int)([self.pickerView selectedRowInComponent:2] +1);
    NSString *dateString = [NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
    _date = [self.dateHelper dateFromString:dateString format:@"yyyy-MM-dd"];
    return _date;
}

- (void)setDefaultDate:(NSDate *)defaultDate
{
    _defaultDate = defaultDate;
    
    [self.pickerView selectRow:[self.dateHelper yearIndexOfDate:defaultDate] inComponent:0 animated:YES];
    [self.pickerView selectRow:[self.dateHelper monthIndexOfDate:defaultDate] inComponent:1 animated:YES];
    [self.pickerView selectRow:[self.dateHelper dayIndexOfDate:defaultDate] inComponent:2 animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

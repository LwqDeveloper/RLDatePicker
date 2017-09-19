//
//  RLDateHelper.m
//  RLDataPicker
//
//  Created by mbp on 2017/9/18.
//  Copyright © 2017年 mbp. All rights reserved.
//

#import "RLDateHelper.h"

@interface RLDateHelper ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation RLDateHelper

- (instancetype)init
{
    if (self = [super init]) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
    }
    return self;
}

- (NSInteger)minYear
{
    return [[self stringFromDate:self.minDate format:@"yyyy"] integerValue];
}

- (NSInteger)maxYear
{
    return [[self stringFromDate:self.maxDate format:@"yyyy"] integerValue];
}

- (NSInteger)years
{
    return [self maxYear] -[self minYear] +1;
}

- (NSInteger)monthsOfYear:(NSString *)year
{
    if (year.integerValue < [self minYear]) {
        return 0;
    } else if (year.integerValue < [self maxYear]) {
        return 12;
    } else if (year.integerValue == [self maxYear]) {
        NSString *maxMonth = [self stringFromDate:self.maxDate format:@"MM"];
        return maxMonth.integerValue;
    } else {
        return 0;
    }
}

- (NSInteger)daysOfYear:(NSString *)year month:(NSString *)month
{
    NSString *maxYear = [self stringFromDate:self.maxDate format:@"yyyy"];
    if (year.integerValue == maxYear.integerValue) {
        NSString *maxMonth = [self stringFromDate:self.maxDate format:@"MM"];
        if (month.integerValue == maxMonth.integerValue) {
            NSString *maxDay = [self stringFromDate:self.maxDate format:@"dd"];
            return maxDay.integerValue;
        }
    }
    if (month.integerValue == 1 ||
        month.integerValue == 3 ||
        month.integerValue == 5 ||
        month.integerValue == 7 ||
        month.integerValue == 8 ||
        month.integerValue == 10 ||
        month.integerValue == 12) {
        return 31;
    } else if (month.integerValue == 4 ||
               month.integerValue == 6 ||
               month.integerValue == 9 ||
               month.integerValue == 11) {
        return 30;
    } else {
        if ([self bissextile:year.integerValue]) {
            return 29;
        } else {
            return 28;
        }
    }
}

- (NSInteger)yearIndexOfDate:(NSDate *)date
{
    NSString *minYear = [self stringFromDate:self.minDate format:@"yyyy"];
    NSString *curYear = [self stringFromDate:date format:@"yyyy"];
    return curYear.integerValue -minYear.integerValue;
}

- (NSInteger)monthIndexOfDate:(NSDate *)date
{
    NSString *curMonth = [self stringFromDate:date format:@"MM"];
    return curMonth.integerValue -1;
}

- (NSInteger)dayIndexOfDate:(NSDate *)date
{
    NSString *curDay = [self stringFromDate:date format:@"dd"];
    return curDay.integerValue -1;
}

- (BOOL)bissextile:(NSInteger)year
{
    if ((year %4 == 0 && year %100 != 0) ||
        year %400 == 0) {
        return YES;
    } else {
        return NO;
    }
}

- (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format
{
    [self.dateFormatter setDateFormat:format];
    NSDate *destDate = [self.dateFormatter dateFromString:dateString];
    return destDate;
}

- (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    [self.dateFormatter setDateFormat:format];
    NSString *destDateString = [self.dateFormatter stringFromDate:date];
    return destDateString;
}

//18岁
- (NSDate *)minSelectAge
{
    NSString *timeStr = [self stringFromDate:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"];
    NSArray *array = [timeStr componentsSeparatedByString:@"-"];
    NSArray *beforeArray = @[[NSString stringWithFormat:@"%@",@([array[0] intValue] -18)],array[1],array[2]];
    NSString *beforeTimeStr = [beforeArray componentsJoinedByString:@"-"];
    return [self dateFromString:beforeTimeStr format:@"yyyy-MM-dd HH:mm:ss"];
}

//70岁
- (NSDate *)maxSelectAge
{
    NSString *timeStr = [self stringFromDate:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"];
    NSArray *array = [timeStr componentsSeparatedByString:@"-"];
    NSArray *beforeArray = @[[NSString stringWithFormat:@"%@",@([array[0] intValue] -70)],array[1],array[2]];
    NSString *beforeTimeStr = [beforeArray componentsJoinedByString:@"-"];
    return [self dateFromString:beforeTimeStr format:@"yyyy-MM-dd HH:mm:ss"];
}

@end

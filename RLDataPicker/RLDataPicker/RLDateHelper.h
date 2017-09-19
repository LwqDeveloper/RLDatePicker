//
//  RLDateHelper.h
//  RLDataPicker
//
//  Created by mbp on 2017/9/18.
//  Copyright © 2017年 mbp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RLDateHelper : NSObject

@property (nonatomic, strong) NSDate *minDate;

@property (nonatomic, strong) NSDate *maxDate;

- (NSInteger)minYear;

- (NSInteger)maxYear;

- (NSInteger)years;

- (NSInteger)monthsOfYear:(NSString *)year;

- (NSInteger)daysOfYear:(NSString *)year month:(NSString *)month;

- (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format;

- (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

- (NSInteger)yearIndexOfDate:(NSDate *)date;

- (NSInteger)monthIndexOfDate:(NSDate *)date;

- (NSInteger)dayIndexOfDate:(NSDate *)date;

@end

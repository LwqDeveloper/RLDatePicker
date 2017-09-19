//
//  RLDataPicker.h
//  RLDataPicker
//
//  Created by mbp on 2017/9/18.
//  Copyright © 2017年 mbp. All rights reserved.
//

#import "RLBaseView.h"

@interface RLDataPicker : RLBaseView

@property (nonatomic, strong) NSDate *defaultDate;

- (instancetype)initWithFrame:(CGRect)frame maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate completion:(void(^)(NSDate *))completion;

@end

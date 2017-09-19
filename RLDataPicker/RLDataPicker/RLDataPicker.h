//
//  RLDataPicker.h
//  RLDataPicker
//
//  Created by mbp on 2017/9/18.
//  Copyright © 2017年 mbp. All rights reserved.
//

#import "RLBaseView.h"

@interface RLDataPicker : RLBaseView

+ (instancetype)showWithDefaultDate:(NSDate *)defaultDate minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate completion:(void(^)(NSDate *))completion;

@end

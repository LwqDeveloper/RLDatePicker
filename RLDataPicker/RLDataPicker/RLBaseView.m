//
//  RLBaseView.m
//  JianAi360
//
//  Created by mbp on 2017/5/18.
//  Copyright © 2017年 jiduo. All rights reserved.
//

#import "RLBaseView.h"

@implementation RLBaseView

- (void)rl_addBgView
{
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.tag = 10086;
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rl_hide)]];
    [self addSubview:view];
    [self insertSubview:view atIndex:0];
}

- (void)rl_removeBgView
{
    UIView *view = [self viewWithTag:10086];
    [view removeFromSuperview];
}

- (void)rl_showInView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.superview) {
            [view addSubview:self];
            [view bringSubviewToFront:self];
        }
        if (![self.superview isEqual:view]) {
            [self removeFromSuperview];
            [view addSubview:self];
            [view bringSubviewToFront:self];
        }
        
        [view bringSubviewToFront:self];
        self.alpha = 0;
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1;
            self.hidden = NO;
        }];
    });
}

- (void)rl_hide
{
    [self rl_hideCompletion:nil];
}

- (void)rl_hideCompletion:(void(^)(void))completion
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
            self.hidden = YES;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
                if (completion) {
                    completion();
                }
            }
        }];
    });
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

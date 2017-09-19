//
//  RLBaseView.h
//  JianAi360
//
//  Created by mbp on 2017/5/18.
//  Copyright © 2017年 jiduo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RLBaseView : UIView

- (void)rl_addBgView;

- (void)rl_removeBgView;

- (void)rl_showInView:(UIView *)view;

- (void)rl_hide;

- (void)rl_hideCompletion:(void(^)(void))completion;

@end

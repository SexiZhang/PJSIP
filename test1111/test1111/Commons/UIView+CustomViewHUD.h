//
//  UIView+CustomViewHUD.h
//  test1111
//
//  Created by 张莹莹 on 16/10/26.
//  Copyright © 2016年 ZYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CustomViewHUD)

- (void)addCustomViewHUDWithTitle:(NSString*)title andImageName:(NSString*)imageName;
- (void)addAlertLabelHUDWithTitle:(NSString *)title;

@end

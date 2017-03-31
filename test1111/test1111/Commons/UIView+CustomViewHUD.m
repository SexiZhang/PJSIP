//
//  UIView+CustomViewHUD.m
//  test1111
//
//  Created by 张莹莹 on 16/10/26.
//  Copyright © 2016年 ZYY. All rights reserved.
//

#import "UIView+CustomViewHUD.h"
#import "MBProgressHUD.h"

@implementation UIView (CustomViewHUD)

- (void)addCustomViewHUDWithTitle:(NSString*)title andImageName:(NSString*)imageName {
    MBProgressHUD *hud = [[MBProgressHUD alloc ] initWithView:self];
    [self addSubview:hud];
    hud.label.text = title;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.mode = MBProgressHUDModeCustomView;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.5];
}
- (void)addAlertLabelHUDWithTitle:(NSString*)title {
    MBProgressHUD * hud = [[MBProgressHUD alloc ] initWithView:self];
    [self addSubview:hud];
    hud.label.text = title;
    hud.mode = MBProgressHUDModeCustomView;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.5];
}

@end

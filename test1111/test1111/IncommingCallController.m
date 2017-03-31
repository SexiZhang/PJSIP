//
//  IncommingCallController.m
//  PhoneTest
//
//  Created by 张莹莹 on 16/10/10.
//  Copyright © 2016年 ZYY. All rights reserved.
//

#import "IncommingCallController.h"

@interface IncommingCallController ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;


@end

@implementation IncommingCallController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.phoneNumLabel.text = _phoneNumber;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallStatusChanged:) name:@"SIPCallStatusChangedNotification" object:nil];
    pjsua_call_answer((pjsua_call_id)_callId, 180, NULL, NULL);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 状态变化
- (void)handleCallStatusChanged:(NSNotification *)notification {
    pjsua_call_id call_id = [notification.userInfo[@"call_id"] intValue];
    pjsip_inv_state state = [notification.userInfo[@"state"] intValue];
    if (call_id != self.callId) {
        return;
    }
    if (state == PJSIP_INV_STATE_DISCONNECTED) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (state == PJSIP_INV_STATE_CONNECTING) {
        NSLog(@"连接中");
    } else if (state == PJSIP_INV_STATE_CONFIRMED) {
        NSLog(@"接听成功！");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hangUpAction:(UIButton *)sender {
    pjsua_call_hangup((pjsua_call_id)_callId, 0, NULL, NULL);
}

- (IBAction)answerAction:(UIButton *)sender {
    sender.enabled = NO;
    pjsua_call_answer((pjsua_call_id)_callId, 200, NULL, NULL);
}


@end

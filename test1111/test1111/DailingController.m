//
//  DailingController.m
//  test1111
//
//  Created by 张莹莹 on 16/10/26.
//  Copyright © 2016年 ZYY. All rights reserved.
//

#import "DailingController.h"
#import "VideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#define kRecordAudioFile @"myRecord.caf"

@interface DailingController ()
{
    pjsua_conf_port_id pjsipConfAudioId;
}

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;

@property (weak, nonatomic) IBOutlet UIButton *hangUpBtn;
@property (weak, nonatomic) IBOutlet UIButton *soundBtn;
@property (weak, nonatomic) IBOutlet UIButton *recoardBtn;
@property (weak, nonatomic) IBOutlet UIButton *hangUp;
@property (weak, nonatomic) IBOutlet UIButton *recoard;
@property (weak, nonatomic) IBOutlet UIButton *sound;

@end

@implementation DailingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.phoneNumLabel.text = _phoneNum;
    
    self.soundBtn.enabled = NO;
    self.recoardBtn.enabled = NO;
    self.recoard.enabled = NO;
    self.sound.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCllStatusChanged:) name:@"SIPCallStatusChangedNotification" object:nil];
}

// 呼叫状态
- (void)handleCllStatusChanged:(NSNotification *)notification {
    pjsua_call_id call_id = [notification.userInfo[@"call_id"] intValue];
    pjsip_inv_state state = [notification.userInfo[@"state"] intValue];
    
    if (call_id != _callId) {
        return;
    }
    
    if (state == PJSIP_INV_STATE_DISCONNECTED) {
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"可以呼叫");
    } else if (state == PJSIP_INV_STATE_CONNECTING) {
        NSLog(@"呼叫中。。。");
    } else if (state == PJSIP_INV_STATE_CONFIRMED) {
        NSLog(@"接通。。。可以选择挂断");
        if (_num == 0) {
            self.soundBtn.enabled = YES;
            self.recoardBtn.enabled = YES;
            self.recoard.enabled = YES;
            self.sound.enabled = YES;
        } else {
//            VideoViewController *videoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
//            [self presentViewController:videoVC animated:YES completion:nil];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hangUpAction:(UIButton *)sender {
    pjsua_call_hangup((pjsua_call_id)_callId, 0, NULL, NULL);
}

// 静音
- (IBAction)soundOffAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self unmuteMicrophone];
    } else {
        [self muteMicrophone];
    }
}

// 静音
- (void)muteMicrophone {
    @try {
        if(pjsipConfAudioId != 0) {
            NSLog(@"WC_SIPServer microphone disconnected from call");
            pjsua_conf_disconnect(0, pjsipConfAudioId);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Unable to mute microphone: %@", exception);
    }
}

// 取消静音
- (void)unmuteMicrophone {
    @try {
        if(pjsipConfAudioId != 0) {
            NSLog(@"WC_SIPServer microphone reconnected to call");
            pjsua_conf_connect(0,pjsipConfAudioId);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Unable to un-mute microphone: %@", exception);
    }
}

// 录音
- (IBAction)recordingAction:(UIButton *)sender {
     [self.view addAlertLabelHUDWithTitle:@"暂不支持录音功能"];
}

@end

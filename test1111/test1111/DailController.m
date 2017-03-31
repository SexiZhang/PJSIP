//
//  DailController.m
//  test1111
//
//  Created by 张莹莹 on 16/10/25.
//  Copyright © 2016年 ZYY. All rights reserved.
//

#import "DailController.h"
#import "DailingController.h"

@interface DailController () {
    pjsua_call_id _call_id;
}

@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourBtn;
@property (weak, nonatomic) IBOutlet UIButton *fiveBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixBtn;
@property (weak, nonatomic) IBOutlet UIButton *sevenBtn;
@property (weak, nonatomic) IBOutlet UIButton *eightBtn;
@property (weak, nonatomic) IBOutlet UIButton *nineBtn;
@property (weak, nonatomic) IBOutlet UIButton *zeroBtn;
@property (weak, nonatomic) IBOutlet UIButton *xingBtn;
@property (weak, nonatomic) IBOutlet UIButton *jingBtn;

@property (weak, nonatomic) IBOutlet UIButton *dailBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

@implementation DailController

-(void)viewDidLayoutSubviews {
    float width = self.oneBtn.frame.size.width;
    self.oneBtn.layer.cornerRadius = width / 2;
    self.oneBtn.layer.masksToBounds = YES;
    self.oneBtn.layer.borderWidth = 1;
    self.oneBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.twoBtn.layer.cornerRadius = width / 2;
    self.twoBtn.layer.masksToBounds = YES;
    self.twoBtn.layer.borderWidth = 1;
    self.twoBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.threeBtn.layer.cornerRadius = width / 2;
    self.threeBtn.layer.masksToBounds = YES;
    self.threeBtn.layer.borderWidth = 1;
    self.threeBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.fourBtn.layer.cornerRadius = width / 2;
    self.fourBtn.layer.masksToBounds = YES;
    self.fourBtn.layer.borderWidth = 1;
    self.fourBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.fiveBtn.layer.cornerRadius = width / 2;
    self.fiveBtn.layer.masksToBounds = YES;
    self.fiveBtn.layer.borderWidth = 1;
    self.fiveBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.sixBtn.layer.cornerRadius = width / 2;
    self.sixBtn.layer.masksToBounds = YES;
    self.sixBtn.layer.borderWidth = 1;
    self.sixBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.sevenBtn.layer.cornerRadius = width / 2;
    self.sevenBtn.layer.masksToBounds = YES;
    self.sevenBtn.layer.borderWidth = 1;
    self.sevenBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.eightBtn.layer.cornerRadius = width / 2;
    self.eightBtn.layer.masksToBounds = YES;
    self.eightBtn.layer.borderWidth = 1;
    self.eightBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.nineBtn.layer.cornerRadius = width / 2;
    self.nineBtn.layer.masksToBounds = YES;
    self.nineBtn.layer.borderWidth = 1;
    self.nineBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.zeroBtn.layer.cornerRadius = width / 2;
    self.zeroBtn.layer.masksToBounds = YES;
    self.zeroBtn.layer.borderWidth = 1;
    self.zeroBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    self.xingBtn.layer.cornerRadius = width / 2;
    self.xingBtn.layer.masksToBounds = YES;
    self.xingBtn.layer.borderWidth = 1;
    self.xingBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.jingBtn.layer.cornerRadius = width / 2;
    self.jingBtn.layer.masksToBounds = YES;
    self.jingBtn.layer.borderWidth = 1;
    self.jingBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dailBtn.layer.cornerRadius = 20;
    self.dailBtn.layer.masksToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCllStatusChanged:) name:@"SIPCallStatusChangedNotification" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeBackgroundColor:(UIButton *)sender {
    sender.backgroundColor = [UIColor lightGrayColor];
}

- (IBAction)oneAction:(UIButton *)sender {
    self.oneBtn.backgroundColor = [UIColor whiteColor];
    self.twoBtn.backgroundColor = [UIColor whiteColor];
    self.threeBtn.backgroundColor = [UIColor whiteColor];
    self.fourBtn.backgroundColor = [UIColor whiteColor];
    self.fiveBtn.backgroundColor = [UIColor whiteColor];
    self.sixBtn.backgroundColor = [UIColor whiteColor];
    self.sevenBtn.backgroundColor = [UIColor whiteColor];
    self.eightBtn.backgroundColor = [UIColor whiteColor];
    self.nineBtn.backgroundColor = [UIColor whiteColor];
    self.zeroBtn.backgroundColor = [UIColor whiteColor];
    self.xingBtn.backgroundColor = [UIColor whiteColor];
    self.jingBtn.backgroundColor = [UIColor whiteColor];
    
    if (self.numTF.text) {
        NSString *str = self.numTF.text;
        self.numTF.text = [str stringByAppendingString:sender.titleLabel.text];
    } else {
        self.numTF.text = sender.titleLabel.text;
    }
}

// 呼叫状态
- (void)handleCllStatusChanged:(NSNotification *)notification {
    pjsua_call_id call_id = [notification.userInfo[@"call_id"] intValue];
    pjsip_inv_state state = [notification.userInfo[@"state"] intValue];
    
    if (call_id != _call_id) {
        return;
    }
    
    if (state == PJSIP_INV_STATE_DISCONNECTED) {
        NSLog(@"可以呼叫");
    } else if (state == PJSIP_INV_STATE_CONNECTING) {
        NSLog(@"呼叫中。。。");
    } else if (state == PJSIP_INV_STATE_CONFIRMED) {
        NSLog(@"接通。。。可以选择挂断");
    }
}

- (void)switchToDailingVC:(int)num {
    DailingController *dailingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DailingController"];
    dailingViewController.phoneNum = self.numTF.text;
    dailingViewController.callId = _call_id;
    dailingViewController.num = num;
    [self presentViewController:dailingViewController animated:YES completion:nil];
//    CATransition *transition = [[CATransition alloc] init];
//    
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    transition.type = kCATransitionFade;
//    transition.duration  = 0.5;
//    transition.removedOnCompletion = YES;
//    
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    [keyWindow.layer addAnimation:transition forKey:@"change_view_controller"];
//    
//    keyWindow.rootViewController = dailingViewController;
}

// 呼叫
- (IBAction)dailAction:(UIButton *)sender {
    if (self.numTF.text) {
        pjsua_acc_id acct_id = (pjsua_acc_id)[[NSUserDefaults standardUserDefaults] integerForKey:@"login_account_id"];
        NSString *server = [[NSUserDefaults standardUserDefaults] stringForKey:@"server_uri"];
        NSString *targetUri = [NSString stringWithFormat:@"sip:%@@%@", self.numTF.text, server];
        
        pj_status_t status;
        pj_str_t dest_uri = pj_str((char *)targetUri.UTF8String);
        
        status = pjsua_call_make_call(acct_id, &dest_uri, 0, NULL, NULL, &_call_id);
        
        if (status != PJ_SUCCESS) {
            char  errMessage[PJ_ERR_MSG_SIZE];
            pj_strerror(status, errMessage, sizeof(errMessage));
            NSLog(@"外拨错误, 错误信息:%d(%s) !", status, errMessage);
        }
        
        [self switchToDailingVC:0];
    } else {
        [self.view addAlertLabelHUDWithTitle:@"呼叫号码不能为空"];
    }
}

- (IBAction)videoAction:(UIButton *)sender {
    
    [self.view addAlertLabelHUDWithTitle:@"暂不支持视频通话功能"];
    
}


@end

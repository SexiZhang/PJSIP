  //
//  LoginViewController.m
//  PhoneTest
//
//  Created by 张莹莹 on 16/10/10.
//  Copyright © 2016年 ZYY. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *serveAddressTF;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRegisterStatus:) name:@"SIPRegisterStatusNotification" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleRegisterStatus:(NSNotification *)notification {
    pjsua_acc_id acc_id = [notification.userInfo[@"acc_id"] intValue];
    pjsip_status_code status = [notification.userInfo[@"status"] intValue];
    NSString *statusText = notification.userInfo[@"status_text"];
    
    if (status != PJSIP_SC_OK) {
        NSLog(@"登录失败，错误信息：%d（%@）", status, statusText);
        if (status == PJSIP_SC_FORBIDDEN) {
            [self.view addAlertLabelHUDWithTitle:@"账号或密码错误"];
        }
        return;
    } 
    
    [[NSUserDefaults standardUserDefaults] setInteger:acc_id forKey:@"login_account_id"];
    [[NSUserDefaults standardUserDefaults] setObject:_serveAddressTF.text forKey:@"server_uri"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self switchToDailVC];
}

- (void)switchToDailVC {
    UIViewController *dialViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DailController"];
    
    CATransition *transition = [[CATransition alloc] init];
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionFade;
    transition.duration  = 0.5;
    transition.removedOnCompletion = YES;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow.layer addAnimation:transition forKey:@"change_view_controller"];
    
    keyWindow.rootViewController = dialViewController;
}

- (IBAction)loginAction:(id)sender {
    if (_usernameTF.text && _passwordTF.text && _serveAddressTF.text) {
        pjsua_acc_id acc_id;
        pjsua_acc_config cfg;
        
        // 调用这个函数来初始化帐户配置与默认值
        pjsua_acc_config_default(&cfg);
        cfg.id = pj_str((char *)[NSString stringWithFormat:@"sip:%@@%@", _usernameTF.text, _serveAddressTF.text].UTF8String);
        // 这是URL放在请求URI的注册，看起来就像“SIP服务提供商”。如果需要注册，则应指定此字段。如果价值是空的，没有帐户注册将被执行。
        cfg.reg_uri = pj_str((char *)[NSString stringWithFormat:@"sip:%@", _serveAddressTF.text].UTF8String);
        // 在注册失败时指定自动注册重试的时间间隔,0禁用自动重新注册
        cfg.reg_retry_interval = 0;
        cfg.cred_count = 1;
        // 凭证数组。如果需要注册，通常至少应该有一个凭据指定，成功地对服务提供程序进行身份验证。可以指定更多的凭据，例如，当请求被期望在路由集中的代理受到挑战时。
        cfg.cred_info[0].realm = pj_str("*");
        cfg.cred_info[0].username = pj_str((char *)_usernameTF.text.UTF8String);
        cfg.cred_info[0].data_type = PJSIP_CRED_DATA_PLAIN_PASSWD;
        cfg.cred_info[0].data = pj_str((char *)_passwordTF.text.UTF8String);
        
        // 指定传入的视频是否自动显示在屏幕上
        cfg.vid_in_auto_show = PJ_TRUE;
        // 设定当有视频来电，或拨出电话时，是否默认激活视频传出
        cfg.vid_out_auto_transmit = PJ_TRUE;
        cfg.vid_cap_dev = PJMEDIA_VID_DEFAULT_CAPTURE_DEV;
        
        pj_status_t status = pjsua_acc_add(&cfg, PJ_TRUE, &acc_id);
        if (status != PJ_SUCCESS) {
            NSString *errorMessage = [NSString stringWithFormat:@"登录失败，返回错误号：%d!", status];
            NSLog(@"register error: %@", errorMessage);
            [self.view addAlertLabelHUDWithTitle:errorMessage];
        }
    } else {
        [self.view addAlertLabelHUDWithTitle:@"服务器地址、账号和密码均不能为空"];
    }
}


@end

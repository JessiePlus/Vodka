//
//  DLSettingsViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/26.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedbackViewController.h"
#import <Masonry.h>
#import "AppUtil.h"
#import <XMNetworking.h>




@interface DLFeedbackViewController ()

@property (nonatomic) UITextField *contentTF;
@property (nonatomic) UITextField *contactTF;
@property (nonatomic) UIButton *sendBtn;


@end

@implementation DLFeedbackViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        DDLogInfo(@"DLFeedbackViewController init");
    }
    
    return self;
}

-(void)dealloc {
    DDLogInfo(@"DLFeedbackViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Feedback", comment: "");
    
    [self.view addSubview:self.contentTF];
    [self.view addSubview:self.contactTF];
    [self.view addSubview:self.sendBtn];

    [self.contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@120);
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(20);
    }];
    
    [self.contactTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@40);
        make.top.equalTo(self.contentTF.mas_bottom).offset(20);
    }];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@40);
        make.top.equalTo(self.contactTF.mas_bottom).offset(20);
    }];

    [self.contentTF becomeFirstResponder];

}

-(UITextField *)contentTF {
    if (!_contentTF) {
        _contentTF = [[UITextField alloc] init];
        _contentTF.backgroundColor = [UIColor whiteColor];
        _contentTF.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
        [_contentTF setPlaceholder:NSLocalizedString(@"Your questions", comment: "")];
    }
    
    return _contentTF;
}

-(UITextField *)contactTF {
    if (!_contactTF) {
        _contactTF = [[UITextField alloc] init];
        _contactTF.backgroundColor = [UIColor whiteColor];
        _contactTF.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
        [_contactTF setPlaceholder:NSLocalizedString(@"Your contact", comment: "")];

    }
    
    return _contactTF;
}

-(UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] init];
        _sendBtn.backgroundColor = [UIColor whiteColor];
        [_sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
        [_sendBtn setTitle:NSLocalizedString(@"Send", comment: "") forState:UIControlStateNormal];
        
        [_sendBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sendBtn;
}

-(void)btnClicked:(UIButton *)sender {
    
    NSString *content = self.contentTF.text;
    if (!content || content.length == 0) {
        return;
    }
    
    NSString *contact = self.contactTF.text;
    if (!contact || contact.length == 0) {
        return;
    }
    
    [XMCenter sendRequest:^(XMRequest *request) {
        request.api = @"feedback";
        request.parameters = @{@"status": @"open", @"content": content, @"contact":contact};
        request.headers = @{};
        request.httpMethod = kXMHTTPMethodPOST;
        request.requestSerializerType = kXMRequestSerializerJSON;
    } onSuccess:^(id responseObject) {
        
        
        [self leftBtnClicked];
        
    } onFailure:^(NSError *error) {
        DDLogError(@"onFailure: %@", error);
    } onFinished:^(id responseObject, NSError *error) {
        DDLogInfo(@"onFinished");
    }];
    
    
    


}

-(void)leftBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  BJCreateQRCodeController.m
//  QRDemo
//
//  Created by zbj-mac on 16/7/19.
//  Copyright © 2016年 zbj. All rights reserved.
//
//二维码生成
#import "BJCreateQRCodeController.h"
#import "BJCreateQRCode.h"
@interface BJCreateQRCodeController ()
@property(nonatomic,strong)UIImageView*qrCodeImageView;
@end

@implementation BJCreateQRCodeController
-(UIImageView *)qrCodeImageView{
    if (!_qrCodeImageView) {
        _qrCodeImageView=[[UIImageView alloc] init];
        _qrCodeImageView.frame=CGRectMake(0, 0, 200, 200);
    }
    return _qrCodeImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.qrCodeImageView.center=self.view.center;
    [self.view addSubview:self.qrCodeImageView];

    
    self.qrCodeImageView.image=[[BJCreateQRCode share] createHDQRCodeImageWith:@"天王盖地虎" onColor:nil offColor:nil codeSize:200 logo:[UIImage imageNamed:@"picture"] radius:10];
}


@end

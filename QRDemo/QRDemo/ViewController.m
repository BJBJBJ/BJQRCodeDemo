//
//  ViewController.m
//  QRDemo
//
//  Created by zbj-mac on 16/7/18.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import "ViewController.h"
#import "BJQRCodeHeader.h"
#import "BJScanQRCodeController.h"
#import "BJReadQRCodeController.h"
#import "BJCreateQRCodeController.h"
@interface ViewController ()

@property(nonatomic,strong)UIButton*scanBtn;
@property(nonatomic,strong)UIButton*readBtn;
@property(nonatomic,strong)UIButton*createBtn;

@end

@implementation ViewController
-(UIButton *)scanBtn{
    if (!_scanBtn) {
        _scanBtn=[[UIButton alloc] init];
        _scanBtn.height=50;
        _scanBtn.width=150;
        _scanBtn.centerX=kDeviceWidth*0.5;
        _scanBtn.y=kDeviceHeight*0.5-120;
        [_scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
        [_scanBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_scanBtn addTarget:self action:@selector(scanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanBtn;
}
-(UIButton *)readBtn{
    if (!_readBtn) {
        _readBtn=[[UIButton alloc] init];
        _readBtn.height=_scanBtn.height;
        _readBtn.width=_scanBtn.width;
        _readBtn.centerX=_scanBtn.centerX;
        _readBtn.y=_scanBtn.bottom+20;
        [_readBtn setTitle:@"从相册读取" forState:UIControlStateNormal];
        [_readBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_readBtn addTarget:self action:@selector(readBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _readBtn;
}
-(UIButton *)createBtn{
    if (!_createBtn) {
        _createBtn=[[UIButton alloc] init];
        _createBtn.height=_readBtn.height;
       _createBtn.width=_readBtn.width;
        _createBtn.centerX=_readBtn.centerX;
        _createBtn.y=_readBtn.bottom+20;
        [_createBtn setTitle:@"生成二维码" forState:UIControlStateNormal];
        [_createBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_createBtn addTarget:self action:@selector(createBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
     
    }
    return _createBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scanBtn];
    [self.view addSubview:self.readBtn];
    [self.view addSubview:self.createBtn];
    //    [self.navigationController.navigationBar setHidden:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scanBtnClicked:(UIButton*)btn{
    
    BJScanQRCodeController *control=[[BJScanQRCodeController alloc] init];
    control.title=@"扫一扫";
    [self.navigationController pushViewController:control animated:YES];
    
}
-(void)readBtnClicked:(UIButton*)btn{
    
    BJReadQRCodeController*control=[[BJReadQRCodeController alloc] init];
    control.title=@"识别二维码";
    [self.navigationController pushViewController:control animated:YES];
}
-(void)createBtnClicked:(UIButton*)btn{
    
    BJCreateQRCodeController *control=[[BJCreateQRCodeController alloc] init];
    control.title=@"生成二维码";
    [self.navigationController pushViewController:control animated:YES];
}
@end

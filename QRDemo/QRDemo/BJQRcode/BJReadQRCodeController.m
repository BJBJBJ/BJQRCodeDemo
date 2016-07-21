//
//  BJReadQRCodeController.m
//  QRDemo
//
//  Created by zbj-mac on 16/7/19.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import "BJReadQRCodeController.h"
#import "BJQRCodeHeader.h"
@interface BJReadQRCodeController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIButton*readBtn;
@property(nonatomic,strong)UIImagePickerController*picker;
@property(nonatomic,copy)void (^readQRCodeBlock)(NSString *, NSString *);
@end

@implementation BJReadQRCodeController
-(UIButton *)readBtn{
    if (!_readBtn) {
        _readBtn=[[UIButton alloc] init];
        _readBtn.height=50;
        _readBtn.width=150;
        [_readBtn setTitle:@"读取二维码" forState:UIControlStateNormal];
        [_readBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_readBtn addTarget:self action:@selector(readBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _readBtn;
}
-(void)readBtnClicked:(UIButton*)btn{
    [self checkRight];
}
-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.readBtn.center=self.view.center;
    [self.view addSubview:self.readBtn];
    
    [self checkRight];
    [self readQRCodeCallBack:^(NSString *resultCode, NSString *errorStr) {
       
        if (!errorStr) {
            UIAlertView *altert=[[UIAlertView alloc] initWithTitle:@"读取结果" message:resultCode delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [altert show];
            
        }else{
            
            UIAlertView *altert=[[UIAlertView alloc] initWithTitle:@"error" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [altert show];
            
        }
        
    }];
}
-(void)checkRight{
    WS(ws)
    [BJCheckSystemRight checkPhotosRightCallBack:^(NSError *error) {
        if (!error) {
            [ws openPhotos];
        }else{
            UIAlertView *altert=[[UIAlertView alloc] initWithTitle:@"error" message:error.domain delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [altert show];
        }
    }];
}
/** 打开相册*/
-(void)openPhotos{
    self.picker=[[UIImagePickerController alloc] init];
    self.picker.delegate=self;
    self.picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.picker animated:YES completion:nil];
}
/** 读取二维码*/
-(void)readQRCodeImageWith:(UIImage*)qrCodeImage{
    // 使用 CIDetector 处理 图片
    CIDetector *detector=[CIDetector detectorOfType: CIDetectorTypeQRCode context: nil options: @{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    [self.picker dismissViewControllerAnimated: YES completion:^{
        // 获取结果集(二维码的所有信息都包含在结果集中, 跟扫描出来的二维码的信息是一致的)
        NSArray *results=[detector featuresInImage: [CIImage imageWithCGImage: qrCodeImage.CGImage]];
        if (results!=nil && results.count> 0) {
            //CIQRCodeFeature ios8.0以上可用
            CIQRCodeFeature *qrCode=[results firstObject];
            !self.readQRCodeBlock?:self.readQRCodeBlock(qrCode.messageString,nil);
        }else{
            
             !self.readQRCodeBlock?:self.readQRCodeBlock(nil,@"未识别的二维码");
        }
    }];
}

#pragma mark-----imagePickerController代理-----
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *qrCodeImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    if ([[[UIDevice currentDevice] systemVersion] integerValue]>=8.0) {
        [self readQRCodeImageWith:qrCodeImage];
    }else{
        UIAlertView *altert=[[UIAlertView alloc] initWithTitle:@"error" message:@"当前系统版本不支持识别二维码" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [altert show];
    }
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark---------读取回调----------
-(void)readQRCodeCallBack:(void (^)(NSString *, NSString *))readQRCodeBlock{
    self.readQRCodeBlock=readQRCodeBlock;
}
@end

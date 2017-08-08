//
//  BJQRCodeViewfinder.m
//  QRDemo
//
//  Created by zbj-mac on 16/7/18.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import "BJQRCodeViewfinder.h"
#import <AVFoundation/AVFoundation.h>

@interface BJQRCodeViewfinder()
/**
 *  取景框
 */
@property(nonatomic,strong)UIView*qrViewFinder;
/**
 *  提示label
 */
@property (nonatomic,strong)UILabel*tipLabel;
/**
 *  扫描条
 */
@property(nonatomic,strong)UIImageView*scanLineView;
@property(nonatomic,strong)UIImageView*leftTopView;
@property(nonatomic,strong)UIImageView*rightTopView;
@property(nonatomic,strong)UIImageView*leftBottomView;
@property(nonatomic,strong)UIImageView*rightBottomView;

@property(nonatomic,strong)NSTimer*timer;
@end
@implementation BJQRCodeViewfinder
-(UIView *)qrViewFinder{
    if (!_qrViewFinder) {
        _qrViewFinder=[[UIView alloc] init];
        _qrViewFinder.layer.borderWidth=1;
        _qrViewFinder.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    }
    return _qrViewFinder;
}
-(UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel=[[UILabel alloc] init];
        _tipLabel.textColor=[UIColor redColor];
        _tipLabel.textAlignment=NSTextAlignmentCenter;
        _tipLabel.text=@"将二维码/条码放入取景框内,即可自动扫描";
        _tipLabel.adjustsFontSizeToFitWidth=YES;
    }
    return _tipLabel;
}
-(UIImageView *)scanLineView{
    if (!_scanLineView) {
        _scanLineView=[[UIImageView alloc] init];
        _scanLineView.image=[UIImage imageNamed:@"qr_scan_line"];
        _scanLineView.height=5;
    }
    return _scanLineView;
}
-(UIImageView *)leftTopView{
    if (!_leftTopView) {
        _leftTopView=[BJQRCodeViewfinder creatrCornerImageViewWithImage:@"qr_top_left"];
    }
    return _leftTopView;
}
-(UIImageView *)rightTopView{
    if (!_rightTopView) {
        _rightTopView=[BJQRCodeViewfinder creatrCornerImageViewWithImage:@"qr_top_right"];
    }
    return _rightTopView;
}
-(UIImageView *)leftBottomView{
    if (!_leftBottomView) {
        _leftBottomView=[BJQRCodeViewfinder creatrCornerImageViewWithImage:@"qr_bottom_left"];
    }
    return _leftBottomView;
}
-(UIImageView *)rightBottomView{
    if (!_rightBottomView) {
        _rightBottomView=[BJQRCodeViewfinder creatrCornerImageViewWithImage:@"qr_bottom_right"];
    }
    return _rightBottomView;
}
/**
 *  生成边角视图
 *  @return UIImageView
 */
+(UIImageView*)creatrCornerImageViewWithImage:(NSString*)image{
    UIImageView*aview=[[UIImageView alloc] init];
    aview.image=[UIImage imageNamed:image];
    [aview sizeToFit];
    return aview;
}

-(instancetype)init{
    if (self=[super init]) {
        [self addSubview:self.qrViewFinder];
        [self addSubview:self.tipLabel];
        [self.qrViewFinder addSubview:self.scanLineView];
        [self.qrViewFinder addSubview:self.leftTopView];
        [self.qrViewFinder addSubview:self.rightTopView];
        [self.qrViewFinder addSubview:self.leftBottomView];
        [self.qrViewFinder addSubview:self.rightBottomView];

    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self layOut];
}
/**
 *  布局
 */
-(void)layOut{
    
    CGFloat tipHight=20;
    self.qrViewFinder.width=self.width;
    self.qrViewFinder.height=self.height-tipHight;
    self.tipLabel.y=self.qrViewFinder.bottom;
    self.tipLabel.width=self.width;
    self.tipLabel.height=tipHight;
    
    self.scanLineView.width=self.width;
    CGFloat gap=5;
    self.leftTopView.x=gap;
    self.leftTopView.y=gap;
    
    self.rightTopView.x=self.width-self.rightTopView.width-gap;
    self.rightTopView.y=self.leftTopView.y;
    
    self.leftBottomView.x=self.leftTopView.x;
    self.leftBottomView.y=self.height-self.leftBottomView.height-tipHight-gap;
    
    self.rightBottomView.x=self.rightTopView.x;
    self.rightBottomView.y=self.leftBottomView.y;
    
    
}

+(instancetype)qrCodeViewfinder{
    return [[self alloc] init];
}
-(void)scanLineStartRoll{
    self.timer=self.timer?:[NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(scanLineMoveUpAndDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}
-(void)scanLineStopRoll{
    [self removeTimer];
    self.scanLineView.hidden=YES;
}
/** 移除定时器*/
-(void)removeTimer{
    !self.timer?:[self.timer invalidate];
    self.timer=nil;
}
-(void)scanLineMoveUpAndDown{
    self.scanLineView.hidden=NO;
    self.scanLineView.y=0;
    [UIView animateWithDuration:1.95 animations:^{
        
        self.scanLineView.y=self.height-self.tipLabel.height-self.scanLineView.height;
    } completion:^(BOOL finished) {
        self.scanLineView.hidden=YES;
        
    }];
}
-(void)dealloc{
    [self removeTimer];
}

@end

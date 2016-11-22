//
//  QRCodeView.m
//  allScreenBack
//
//  Created by sherlock on 2016/11/22.
//  Copyright © 2016年 xiaqi. All rights reserved.
//

#import "QRCodeViewC.h"
#import <AVFoundation/AVFoundation.h>
#import <SafariServices/SafariServices.h>
#import "NEQRPreview.h"

@interface QRCodeViewC()<AVCaptureMetadataOutputObjectsDelegate>
//输入设备
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
//输出设备
@property (nonatomic, strong) AVCaptureMetadataOutput *metadataOutput;
//会话 链接输入设备和输出设备
@property (nonatomic, strong) AVCaptureSession *session;
//预览页面
@property (nonatomic, strong) NEQRPreview *preview;
@end

@implementation QRCodeViewC


- (void)viewDidLoad{
    [super viewDidLoad];
 
    
    //输入设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.deviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:device error:nil];
    //输出设备
     self.metadataOutput = [[AVCaptureMetadataOutput alloc]init];
    [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //会话
    self.session = [[AVCaptureSession alloc]init];
    if([self.session canAddInput:self.deviceInput]){
        [self.session addInput:self.deviceInput];
    }
    if ([self.session canAddOutput:self.metadataOutput]) {
        [self.session addOutput:self.metadataOutput];
    }
    self.metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    //预览页面
    self.preview = [[NEQRPreview alloc]initWithFrame:self.view.bounds];
    self.preview.session = self.session;
    
    [self.view addSubview:self.preview];
    
    [self.session startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    //关闭会话
    [self.session stopRunning];
    [self.preview removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];

    //使用Safari 控制器 加载页面
    if ([[metadataObjects.firstObject stringValue] hasPrefix:@"http"]||[[metadataObjects.firstObject stringValue] hasPrefix:@"https"]) {
        SFSafariViewController *safarVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:[metadataObjects.firstObject stringValue]]];
        [self presentViewController:safarVC animated:YES completion:nil];
        
    }
   
        self.complete([metadataObjects.firstObject stringValue]);
    
}

@end

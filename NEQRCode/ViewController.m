//
//  ViewController.m
//  NEQRCode
//
//  Created by sherlock on 2016/11/22.
//  Copyright © 2016年 xiaqi. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeViewC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender {
    QRCodeViewC *codeViewC = [[QRCodeViewC alloc]init];
    
    codeViewC.complete = ^(NSString *completeStr){
        self.dataLabel.text = completeStr;
    };

    [self presentViewController:codeViewC animated:YES completion:nil];
    
    
}


@end

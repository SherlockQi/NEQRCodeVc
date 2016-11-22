//
//  QRCodeView.h
//  allScreenBack
//
//  Created by sherlock on 2016/11/22.
//  Copyright © 2016年 xiaqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeViewC : UIViewController
@property (nonatomic, copy)  void(^complete)(NSString *data);
@end

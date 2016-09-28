//
//  DrawingView.h
//  TestDrawing
//
//  Created by wuhaoyuan on 15/8/5.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingView : UIView
{
    UILabel *lblSignature;
    CAShapeLayer *shapeLayer;
}

- (UIImage *)getSignatureImage;
- (void)clearSignature;

 
@end

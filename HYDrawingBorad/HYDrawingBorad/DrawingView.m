//
//  DrawingView.m
//  TestDrawing
//
//  Created by wuhaoyuan on 15/8/5.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "DrawingView.h"
@class ViewController;

@interface DrawingView ()
{
    UIBezierPath *beziePath;
    UIImage *incriamge;
    CGPoint points[5];
    uint control;
}
@end

@implementation DrawingView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        //设置多个触摸启动
        [self setMultipleTouchEnabled:NO];
        beziePath = [UIBezierPath bezierPath];
        //笔画大小
        [beziePath setLineWidth:3.0];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [incriamge drawInRect:rect];
    [beziePath stroke];
    [[UIColor redColor] setFill];
    //笔画颜色
    [[UIColor redColor] setStroke];
    [beziePath stroke];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    //获取当前点击位置
    points[0] = [touch locationInView:self];
    
    CGPoint startpoint = points[0];
    CGPoint endpoint = CGPointMake(startpoint.x + 1.5, startpoint.y + 2);
    
    [beziePath moveToPoint:startpoint];
    [beziePath addLineToPoint:endpoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    //获取当前点击位置
    CGPoint touchPoint = [touch locationInView:self];
    control++;
    points[control] = touchPoint;
    if (control == 4) {
        points[3] = CGPointMake((points[2].x + points[4].x)/2.0, (points[2].y + points[4].y)/2.0);
        
        [beziePath moveToPoint:points[0]];
        [beziePath addCurveToPoint:points[3] controlPoint1:points[2] controlPoint2:points[1]];
        //显示笔画路径
        [self setNeedsDisplay];
        
        points[0] = points[3];
        points[1] = points[4];
        control = 1;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self drawBitmapImage];
    [self setNeedsDisplay];
    [beziePath removeAllPoints];
    control = 0;
}

- (void)drawBitmapImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    
    if (!incriamge)
    {
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
        [[UIColor whiteColor] setFill];
        [rectpath fill];
    }
    [incriamge drawAtPoint:CGPointZero];
    
    //Set final color for drawing
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor setStroke];
    [beziePath stroke];
    incriamge = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
}

- (UIImage *)getSignatureImage {
    
    if([lblSignature superview]){
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *signatureImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return signatureImage;
}

- (void)clearSignature{
    incriamge = nil;
    [self setNeedsDisplay];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

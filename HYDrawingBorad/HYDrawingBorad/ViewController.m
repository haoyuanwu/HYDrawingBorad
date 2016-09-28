//
//  ViewController.m
//  TestDrawing
//
//  Created by wuhaoyuan on 15/8/5.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "DrawingView.h"
#import "ImageViewController.h"

@interface ViewController ()
@property(nonatomic,strong)DrawingView *drawingV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 400,100,100);
    [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(200, 400, 100, 100);
    [button1 addTarget:self action:@selector(pushViews) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"图片" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button1];
    
    self.drawingV = [[DrawingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    [self.view addSubview:self.drawingV];
}

-(void)pushViews{
    
    ImageViewController *imageController = [[ImageViewController alloc] init];
    imageController.image = [self.drawingV getSignatureImage];
    [self.navigationController pushViewController:imageController animated:YES];

}
- (void)btnAction{
   [_drawingV clearSignature];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

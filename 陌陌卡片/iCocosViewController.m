//
//  iCocosViewController.m
//  陌陌卡片
//
//  Created by tqy on 16/8/29.
//  Copyright © 2016年 iCocos. All rights reserved.
//

#import "iCocosViewController.h"

#import "iCocosCardViewController.h"

@interface iCocosViewController ()

@end

@implementation iCocosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    iCocosCardViewController *card = [[iCocosCardViewController alloc] init];
    [self.navigationController pushViewController:card animated:YES];
}

@end

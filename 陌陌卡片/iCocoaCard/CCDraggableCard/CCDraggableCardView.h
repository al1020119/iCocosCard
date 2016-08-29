//
//  CCDraggableCardView.h
//  iCocos-陌陌卡片
//
//  Created by iCocos on 16/7/6.
//  Copyright © 2016年 iCocos All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CCDraggableConfig.h"

@interface CCDraggableCardView : UIView

@property (nonatomic) CGAffineTransform originalTransform;

- (void)cc_layoutSubviews;

@end

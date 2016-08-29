//
//  ViewController.m
//  iCocos-陌陌卡片
//
//  Created by iCocos on 16/7/6.
//  Copyright © 2016年 iCocos All rights reserved.
//

#import "iCocosCardViewController.h"
#import "CCDraggableContainer.h"
#import "CustomCardView.h"

#import <Masonry.h>

@interface iCocosCardViewController ()
<
CCDraggableContainerDataSource,
CCDraggableContainerDelegate
>

@property (nonatomic, strong) CCDraggableContainer *container;
@property (nonatomic, strong) NSMutableArray *dataSources;

@property (weak, nonatomic) UIButton *disLikeButton;
@property (weak, nonatomic) UIButton *likeButton;
@property (weak, nonatomic) UIButton *detailBtn;

@end

@implementation iCocosCardViewController

- (void)reloadDataEvent:(id)sender {
    if (self.container) {
        [self.container reloadData];
    }
}

- (void)dislikeEvent:(id)sender {
    [self.container removeFormDirection:CCDraggableDirectionLeft];
}

- (void)likeEvent:(id)sender {
    [self.container removeFormDirection:CCDraggableDirectionRight];
}

- (void)loadUI {
    
    self.container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, 84, CCWidth, CCWidth) style:CCDraggableStyleUpOverlay];
    self.container.delegate = self;
    self.container.dataSource = self;
    [self.view addSubview:self.container];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.container reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self initWithButton];
    
    NSLog(@"%@==%@==%@", self.disLikeButton, self.likeButton, self.detailBtn);
    
    [self loadData];
    [self loadUI];
}


- (void)initWithButton
{
    // 防止block中的循环引用
    __weak typeof (self) weakSelf = self;
    
    UIButton *reloadDataEvent = [[UIButton alloc] init];
    self.detailBtn = reloadDataEvent;
    [self.view addSubview:reloadDataEvent];
    [reloadDataEvent setBackgroundImage:[UIImage imageNamed:@"userInfo"] forState:UIControlStateNormal];
    [reloadDataEvent addTarget:self action:@selector(reloadDataEvent:) forControlEvents:UIControlEventTouchUpInside];
    [reloadDataEvent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.equalTo(weakSelf.view);
        make.bottom.width.offset(-100);
    
    }];
    
    UIButton *dislikeEvent = [[UIButton alloc] init];
    self.disLikeButton = dislikeEvent;
    [dislikeEvent addTarget:self action:@selector(dislikeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dislikeEvent];
    [dislikeEvent setBackgroundImage:[UIImage imageNamed:@"nope"] forState:UIControlStateNormal];
    [dislikeEvent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerY.equalTo(reloadDataEvent);
        make.right.equalTo(reloadDataEvent.mas_left).with.offset(-30);
        
    }];
    
    
    
    UIButton *likeEvent = [[UIButton alloc] init];
    self.likeButton = likeEvent;
    [likeEvent addTarget:self action:@selector(likeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeEvent];
    [likeEvent setBackgroundImage:[UIImage imageNamed:@"liked"] forState:UIControlStateNormal];
    [likeEvent mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerY.equalTo(reloadDataEvent);
        make.left.equalTo(reloadDataEvent.mas_right).with.offset(30);
    }];
    
}

- (void)loadData {
    
    _dataSources = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++) {
        NSDictionary *dict = @{@"image" : [NSString stringWithFormat:@"image_%d.jpg",i + 1],
                               @"title" : [NSString stringWithFormat:@"Page %d",i + 1]};
        [_dataSources addObject:dict];
    }
}

#pragma mark - CCDraggableContainer DataSource

- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    
    CustomCardView *cardView = [[CustomCardView alloc] initWithFrame:draggableContainer.bounds];
    [cardView installData:[_dataSources objectAtIndex:index]];
    return cardView;
}

- (NSInteger)numberOfIndexs {
    return _dataSources.count;
}

#pragma mark - CCDraggableContainer Delegate

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    
    CGFloat scale = 1 + ((kBoundaryRatio > fabs(widthRatio) ? fabs(widthRatio) : kBoundaryRatio)) / 4;
    if (draggableDirection == CCDraggableDirectionLeft) {
        self.disLikeButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
    if (draggableDirection == CCDraggableDirectionRight) {
        self.likeButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    
    NSLog(@"点击了Tag为%ld的Card", (long)didSelectIndex);

}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
   
    [draggableContainer reloadData];
}

@end

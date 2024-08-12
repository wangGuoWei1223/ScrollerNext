//
//  ViewController.m
//  ScrollViewNestOC
//
//  Created by Gavin on 2024/8/12.
//  Copyright © 2024 Gavin. All rights reserved.
//

#import "ViewController.h"
#import "GWScrollView.h"
#import "SyncScrollContext.h"

@interface ViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)GWScrollView *outScrollerView;
@property(nonatomic, strong)GWScrollView *innerScrollerView;
@property(nonatomic, strong)SyncScrollContext *syncScrollContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.syncScrollContext = [SyncScrollContext new];
    self.syncScrollContext.maxinnerOffsetY = 0.f;
    self.syncScrollContext.maxOuterOffsetY = 380.f;
//    self.syncScrollContext.innerEnable = NO;
//    self.syncScrollContext.outerEnable = YES;
    
    self.outScrollerView.frame = CGRectMake(10, 90, 300, 550);
    self.outScrollerView.contentSize = CGSizeMake(300, 1800);
    [self.view addSubview:self.outScrollerView];
    
    self.innerScrollerView.frame = CGRectMake(10, 400, 240, 300);
    self.innerScrollerView.contentSize = CGSizeMake(240, 800);
    [self.outScrollerView addSubview:self.innerScrollerView];
    
    UIView *v1 = [UIView new];
    v1.frame = CGRectMake(90, 0, 90, 90);
    v1.backgroundColor = UIColor.yellowColor;
    [self.innerScrollerView addSubview:v1];
    
    UIView *v2 = [UIView new];
    v2.frame = CGRectMake(90, 90, 90, 90);
    v2.backgroundColor = UIColor.redColor;
    [self.innerScrollerView addSubview:v2];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == self.outScrollerView) {
            CGPoint contentOffset = scrollView.contentOffset;
        if (!self.outScrollerView.canScroll) {
            
            [self.outScrollerView setContentOffset:CGPointMake(0, self.syncScrollContext.maxOuterOffsetY)];
        }
        
        // 修改 内外scrollView 的滚动状态
        if (self.outScrollerView.contentOffset.y >= self.syncScrollContext.maxOuterOffsetY) {
            self.outScrollerView.canScroll = NO;
            self.innerScrollerView.canScroll = YES;
            
            /*
             外层滚动到目标位置后 把滚动距离 传给内存 scrollView
             当外层 scrollerView 滚动到最大值后 内部scrollerView 接着滚动剩余部分
             */
            CGFloat offsetY = contentOffset.y - self.syncScrollContext.maxOuterOffsetY;
            CGPoint innerOffset = self.innerScrollerView.contentOffset;
            innerOffset.y += offsetY;
            [self.innerScrollerView setContentOffset:innerOffset];
            
        } else {
            self.outScrollerView.canScroll = YES;
            self.innerScrollerView.canScroll = NO;
        }
        
    }
    else if (scrollView == self.innerScrollerView) {
        
        if (!self.innerScrollerView.canScroll) {
            [self.innerScrollerView setContentOffset:CGPointMake(0, self.syncScrollContext.maxinnerOffsetY)];
        }
        // 修改 内外scrollView 的滚动状态
        if (self.innerScrollerView.contentOffset.y <= self.syncScrollContext.maxinnerOffsetY) {
            self.innerScrollerView.canScroll = NO;
            self.outScrollerView.canScroll = YES;
        }else {
            self.innerScrollerView.canScroll = YES;
            self.outScrollerView.canScroll = NO;
        }
    }
}

- (GWScrollView *)outScrollerView {
    if (!_outScrollerView) {
        _outScrollerView = [[GWScrollView alloc] init];
        _outScrollerView.delegate = self;
    
        _outScrollerView.backgroundColor = UIColor.blueColor;
    }
    return _outScrollerView;
}

- (GWScrollView *)innerScrollerView {
    if (!_innerScrollerView) {
        _innerScrollerView = [[GWScrollView alloc] init];
        _innerScrollerView.delegate = self;
        _innerScrollerView.backgroundColor = UIColor.grayColor;
    }
    return _innerScrollerView;
}

@end

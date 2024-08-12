//
//  GWScrollView.m
//  OCProject
//
//  Created by Gavin on 2024/8/11.
//  Copyright © 2024 Gavin. All rights reserved.
//

#import "GWScrollView.h"

@interface GWScrollView()<UIGestureRecognizerDelegate>

@end

@implementation GWScrollView 

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _canScroll = YES;
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

@end

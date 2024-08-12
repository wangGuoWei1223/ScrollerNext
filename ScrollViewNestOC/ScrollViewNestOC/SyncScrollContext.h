//
//  SyncScrollContext.h
//  OCProject
//
//  Created by Gavin on 2024/8/11.
//  Copyright © 2024 Gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyncScrollContext : NSObject

@property (nonatomic, assign) CGFloat maxOuterOffsetY;
@property (nonatomic, assign) CGFloat maxinnerOffsetY;
@property(nonatomic, assign) BOOL outerEnable;
@property(nonatomic, assign) BOOL innerEnable;

@end


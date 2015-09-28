//
//  LBScrollLabel.h
//  LBScrollLabelDemo
//
//  Created by luobbe on 15/9/26.
//  Copyright (c) 2015年 luobbe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LBScrollLabelDirection) {
    LBScrollLabelDirection_Top,         //from bottom to top
    LBScrollLabelDirection_Bottom,
    LBScrollLabelDirection_Left,
    LBScrollLabelDirection_Right,
};

//default speed 10
#define LBScrollSpeed     10

@interface LBScrollLabel : UIView

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, copy) NSString *text;
@property (nonatomic) NSTextAlignment textAlignment;
@property (nonatomic) UIFont *font;

- (void)beginScrollWithDirection:(LBScrollLabelDirection)direction; /** move labels*/

@end

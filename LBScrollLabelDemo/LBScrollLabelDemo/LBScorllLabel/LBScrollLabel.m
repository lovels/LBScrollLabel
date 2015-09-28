//
//  LBScrollLabel.m
//  LBScrollLabelDemo
//
//  Created by luobbe on 15/9/26.
//  Copyright (c) 2015年 luobbe. All rights reserved.
//

#import "LBScrollLabel.h"

@interface LBScrollLabel()
{
    CGFloat width;          //LBScrollLabel width
    CGFloat height;
    CGFloat distance;       //move distance per second
    NSTimer *timer;
}

@property (nonatomic, strong) UILabel *aLabel;
@property (nonatomic, strong) UILabel *bLabel;
@property (nonatomic, assign) LBScrollLabelDirection direction;

@end

@implementation LBScrollLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // init labels
        self.layer.masksToBounds = YES;
        width = CGRectGetWidth(self.frame);
        height= CGRectGetHeight(self.frame);
        [self addSubview:self.aLabel];
        [self addSubview:self.bLabel];
        _aLabel.frame = CGRectMake(0, 0, width, height);
        _bLabel.frame = CGRectMake(width, 0, width, height);
    }
    return self;
}

- (void)beginScrollWithDirection:(LBScrollLabelDirection)direction {
    self.direction = direction;
    //move distance per second
    distance = LBScrollSpeed * 0.01;
    //handel long text
    [self handelLabeltextLength];
    //set _bLabel's position
    if (_direction == LBScrollLabelDirection_Top) {
        _bLabel.frame = CGRectMake(0, height, CGRectGetWidth(_bLabel.frame), height);
    }else if (_direction == LBScrollLabelDirection_Bottom) {
        _bLabel.frame = CGRectMake(0, -height, CGRectGetWidth(_bLabel.frame), height);
    }else if (_direction == LBScrollLabelDirection_Left) {
        _bLabel.frame = CGRectMake(CGRectGetMaxX(_aLabel.frame), 0, CGRectGetWidth(_bLabel.frame), height);
    }else if (_direction == LBScrollLabelDirection_Right) {
        _bLabel.frame = CGRectMake(-CGRectGetMaxX(_aLabel.frame), 0, CGRectGetWidth(_bLabel.frame), height);
    }
    if (timer != nil) {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animationLabel) userInfo:nil repeats:YES];
}

- (void)animationLabel {
    
    switch (_direction) {
        case LBScrollLabelDirection_Top:
        {
            if (fabs(CGRectGetMinY(_aLabel.frame))>=height) {
                _aLabel.frame = CGRectMake(0, 0, CGRectGetWidth(_aLabel.frame), height);
                _bLabel.frame = CGRectMake(0, height, CGRectGetWidth(_bLabel.frame), height);
            }
            _aLabel.frame = CGRectMake(0, CGRectGetMinY(_aLabel.frame) - distance, CGRectGetWidth(_aLabel.frame), height);
            _bLabel.frame = CGRectMake(0, CGRectGetMinY(_bLabel.frame) - distance, CGRectGetWidth(_bLabel.frame), height);
        }
            break;
        case LBScrollLabelDirection_Bottom:
        {
            if (fabs(CGRectGetMinY(_aLabel.frame))>=height) {
                _aLabel.frame = CGRectMake(0, 0, CGRectGetWidth(_aLabel.frame), height);
                _bLabel.frame = CGRectMake(0, -height, CGRectGetWidth(_bLabel.frame), height);
            }
            _aLabel.frame = CGRectMake(0, CGRectGetMinY(_aLabel.frame) + distance, CGRectGetWidth(_aLabel.frame), height);
            _bLabel.frame = CGRectMake(0, CGRectGetMinY(_bLabel.frame) + distance, CGRectGetWidth(_bLabel.frame), height);
        }
            break;
        case LBScrollLabelDirection_Left:
        {
            if (fabs(CGRectGetMinX(_aLabel.frame))>=CGRectGetWidth(_aLabel.frame)) {
                _aLabel.frame = CGRectMake(0, 0, CGRectGetWidth(_aLabel.frame), height);
                _bLabel.frame = CGRectMake(CGRectGetMaxX(_aLabel.frame), 0, CGRectGetWidth(_bLabel.frame), height);
            }
            _aLabel.frame = CGRectMake(CGRectGetMinX(_aLabel.frame) - distance, 0, CGRectGetWidth(_aLabel.frame), height);
            _bLabel.frame = CGRectMake(CGRectGetMinX(_bLabel.frame) - distance, 0, CGRectGetWidth(_bLabel.frame), height);
        }
            break;
        case LBScrollLabelDirection_Right:
        {
            if (fabs(CGRectGetMinX(_aLabel.frame))>=CGRectGetWidth(_aLabel.frame)) {
                _aLabel.frame = CGRectMake(0, 0, CGRectGetWidth(_aLabel.frame), height);
                _bLabel.frame = CGRectMake(-CGRectGetMaxX(_aLabel.frame), 0, CGRectGetWidth(_bLabel.frame), height);
            }
            _aLabel.frame = CGRectMake(CGRectGetMinX(_aLabel.frame) + distance, 0, CGRectGetWidth(_aLabel.frame), height);
            _bLabel.frame = CGRectMake(CGRectGetMinX(_bLabel.frame) + distance, 0, CGRectGetWidth(_bLabel.frame), height);
        }
            break;
    }
}

//textColor
- (void)setTextColor:(UIColor *)textColor {
    _aLabel.textColor = textColor;
    _bLabel.textColor = textColor;
}

//text
- (void)setText:(NSString *)text {
    _aLabel.text = text;
    _bLabel.text = text;
    //handel long text
    [self handelLabeltextLength];
}

//textAlignment
- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _aLabel.textAlignment = textAlignment;
    _bLabel.textAlignment = textAlignment;
}

//font
- (void)setFont:(UIFont *)font {
    _aLabel.font = font;
    _bLabel.font = font;
}

// handel text too long
- (void)handelLabeltextLength
{
    if (self.direction == LBScrollLabelDirection_Top || self.direction == LBScrollLabelDirection_Bottom) {
        _aLabel.frame = CGRectMake(_aLabel.frame.origin.x, _aLabel.frame.origin.y, width, height);
        _bLabel.frame = CGRectMake(_bLabel.frame.origin.x, _bLabel.frame.origin.y, width, height);
    }else if (self.direction == LBScrollLabelDirection_Left || self.direction == LBScrollLabelDirection_Right) {
        [_aLabel sizeToFit];
        [_bLabel sizeToFit];
        if (CGRectGetWidth(_aLabel.frame) <= width) {
            //
            _aLabel.frame = CGRectMake(_aLabel.frame.origin.x, _aLabel.frame.origin.y, width, height);
            _bLabel.frame = CGRectMake(_bLabel.frame.origin.x, _bLabel.frame.origin.y, width, height);
        }else{
            _aLabel.frame = CGRectMake(_aLabel.frame.origin.x, _aLabel.frame.origin.y, CGRectGetWidth(_aLabel.frame), height);
            _bLabel.frame = CGRectMake(CGRectGetMaxX(_aLabel.frame), _bLabel.frame.origin.y, CGRectGetWidth(_aLabel.frame), height);
        }
    }
}

- (UILabel *)aLabel {
    if (_aLabel == nil) {
        _aLabel = [UILabel new];
        _aLabel.backgroundColor = [UIColor clearColor];
    }
    return _aLabel;
}

- (UILabel *)bLabel {
    if (_bLabel == nil) {
        _bLabel = [UILabel new];
        _bLabel.backgroundColor = [UIColor clearColor];
    }
    return _bLabel;
}

@end

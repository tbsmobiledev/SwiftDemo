//
//  MLInputDodgerRetractView.m
//  MLInputDodger
//
//  Created by molon on 15/7/28.
//  Copyright (c) 2015年 molon. All rights reserved.
//

#import "MLInputDodgerRetractView.h"

@interface MLInputDodgerRetractView()

@property (nonatomic, strong) UIButton *button;

@end

@implementation MLInputDodgerRetractView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.button];
    }
    return self;
}

#pragma mark - getter
- (UIButton *)button
{
    if (!_button) {
        UIButton *button = [[UIButton alloc]init];
        [button setImage:[UIImage imageNamed:[@"MLInputDodger.bundle" stringByAppendingPathComponent:@"retract"]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(retract) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitle:@"Done" forState:UIControlStateNormal];
        button.layer.cornerRadius = 5.0f;
        button.layer.masksToBounds = NO;
        button.backgroundColor = [UIColor clearColor];
        button.layer.backgroundColor = [UIColor colorWithRed:1.0 green:(145/255.0) blue:(1/255.0) alpha:1.000].CGColor;
        button.layer.rasterizationScale = [UIScreen mainScreen].scale;
        button.layer.shouldRasterize = YES;
        [button setHidden:true];
        _button = button;
    }
    return _button;
}

#pragma mark - event
- (void)retract
{
    if (self.didClickRetractButtonBlock) {
        self.didClickRetractButtonBlock();
    }
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    static CGFloat buttonWidth = 60.0f;
    self.button.frame = CGRectMake(CGRectGetWidth(self.frame)- buttonWidth, 0, buttonWidth, CGRectGetHeight(self.frame)+5);
}

#pragma mark - penetrable

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL result = [super pointInside:point withEvent:event];
    
    if (result) {
        //penetrable except button
        if (!CGRectContainsPoint(self.button.frame, point)) {
            return NO;
        }
    }
    
    return result;
}
@end

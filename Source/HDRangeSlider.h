//
//  HDRangeSlider.h
//  HaidoraRangeSlider
//
//  Created by DaiLingchi on 14-10-19.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import <UIKit/UIKit.h>
@import QuartzCore.QuartzCore;

#pragma mark
#pragma mark HDRangeSlider

@interface HDRangeSlider : UIControl

@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, assign) CGFloat stageValue;

@property (nonatomic, assign) CGFloat leftValue;
@property (nonatomic, assign) CGFloat rightValue;
@property (nonatomic, assign) CGFloat margin;

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *trackHighlightTintColor;
@property (nonatomic, strong) UIColor *thumbColor;

@property (nonatomic, strong) UIColor *stageColor;
@property (nonatomic, strong) UIFont *stageFont;

@property (nonatomic, copy) void (^valueChangeBlock)(CGFloat leftValue, CGFloat rightValue);

@end

#pragma mark
#pragma mark HDRangeSliderTrackLayer

@interface HDRangeSliderTrackLayer : CALayer

@property (nonatomic, weak) HDRangeSlider *rangeSlider;

@end

#pragma mark
#pragma mark HDRangeSliderThumbLayer

@interface HDRangeSliderThumbLayer : CALayer

@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, weak) HDRangeSlider *rangeSlider;

@end

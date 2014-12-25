//
//  HDRangeSlider.h
//  HaidoraRangeSlider
//
//  Created by DaiLingchi on 14-10-19.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import <UIKit/UIKit.h>
//@import QuartzCore.QuartzCore;

#pragma mark
#pragma mark HDRangeSlider

// IB_DESIGNABLE
@interface HDRangeSlider : UIControl

// Slider Config
@property (nonatomic, assign) IBInspectable CGFloat minValue;
@property (nonatomic, assign) IBInspectable CGFloat maxValue;
@property (nonatomic, assign) IBInspectable CGFloat margin;
// Slider Value
@property (nonatomic, assign) IBInspectable CGFloat leftValue;
@property (nonatomic, assign) IBInspectable CGFloat rightValue;

// slider ui
@property (nonatomic, assign) IBInspectable CGFloat trackHeight;
@property (nonatomic, strong) IBInspectable UIColor *trackColor;
@property (nonatomic, strong) IBInspectable UIColor *trackHighlightTintColor;
@property (nonatomic, strong) IBInspectable UIColor *thumbColor;

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

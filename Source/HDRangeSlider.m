//
//  HDRangeSlider.m
//  HaidoraRangeSlider
//
//  Created by DaiLingchi on 14-10-19.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import "HDRangeSlider.h"

#define kMargin_Top 8

#pragma mark
#pragma mark HDRangeSlider

@interface HDRangeSlider ()

@property (nonatomic, strong) HDRangeSliderTrackLayer *trackLayer;
@property (nonatomic, strong) HDRangeSliderThumbLayer *leftThumbLayer;
@property (nonatomic, strong) HDRangeSliderThumbLayer *rightThumbLayer;
@property (nonatomic, assign) CGPoint previousLocation;

@property (nonatomic, assign) CGFloat thumbWidth;
@property (nonatomic, assign) CGFloat thumbHeight;

@end

@implementation HDRangeSlider

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _minValue = 0;
    _maxValue = 10;
    _leftValue = _minValue;
    _rightValue = _maxValue;
    _stageValue = 1;
    _margin = 25;
    _thumbColor = [UIColor whiteColor];
    _trackColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    _trackHighlightTintColor = [UIColor colorWithRed:0.0 green:0.45 blue:0.94 alpha:1.0];
    _stageColor = _trackHighlightTintColor;
    _stageFont = [UIFont boldSystemFontOfSize:9];
    _stageSelectedOnly = NO;

    _trackLayer = [HDRangeSliderTrackLayer layer];
    _trackLayer.contentsScale = [UIScreen mainScreen].scale;
    _trackLayer.rangeSlider = self;
    [self.layer addSublayer:_trackLayer];

    _leftThumbLayer = [HDRangeSliderThumbLayer layer];
    _leftThumbLayer.contentsScale = [UIScreen mainScreen].scale;
    _leftThumbLayer.rangeSlider = self;
    [self.layer addSublayer:_leftThumbLayer];

    _rightThumbLayer = [HDRangeSliderThumbLayer layer];
    _rightThumbLayer.contentsScale = [UIScreen mainScreen].scale;
    _rightThumbLayer.rangeSlider = self;
    [self.layer addSublayer:_rightThumbLayer];

    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (CGFloat)positionForValue:(CGFloat)value
{
    CGFloat percentage = (value - _minValue) / (_maxValue - _minValue);
    return (CGRectGetWidth(self.bounds) - 2 * _margin) * percentage + _margin;
}

- (CGFloat)postionForStageValue:(CGFloat)value __attribute__((deprecated))
{
    CGFloat percentage = (value - _minValue) / (_maxValue - _minValue);
    return (CGRectGetWidth(self.bounds) - 2 * _margin) * percentage + _margin;
}

- (CGFloat)boundaryForValue:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue
{
    return MIN(MAX(value, minValue), maxValue);
}

- (CGFloat)valueForWidth:(CGFloat)width
{
    CGFloat percentage = (_maxValue - _minValue) / (CGRectGetWidth(self.bounds) - 2 * _margin);
    return width * percentage;
}

#pragma mark
#pragma mark Render

- (void)layoutSubviews
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _trackLayer.frame =
        CGRectMake(0, kMargin_Top, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) / 4);
    [_trackLayer setNeedsDisplay];

    CGFloat thumbWidth = self.thumbWidth;
    CGFloat thumbHeight = self.thumbHeight;

    CGFloat leftThumCenter = [self positionForValue:_leftValue];
    _leftThumbLayer.frame = CGRectMake(leftThumCenter - thumbWidth / 2, 0, thumbWidth, thumbHeight);
    [_leftThumbLayer setNeedsDisplay];

    CGFloat rightThumCenter = [self positionForValue:_rightValue];
    _rightThumbLayer.frame =
        CGRectMake(rightThumCenter - thumbWidth / 2, 0, thumbWidth, thumbHeight);
    [_rightThumbLayer setNeedsDisplay];
    [CATransaction commit];
}

- (void)drawRect:(CGRect)rect
{
    NSInteger number = (_maxValue - _minValue) / _stageValue;
    for (int i = 0; i <= number; i++)
    {
        CGFloat posX = [self positionForValue:i * _stageValue];
        NSString *sep = @"|";
        NSString *value = [NSString stringWithFormat:@"%0.0f", i * _stageValue];
        NSDictionary *attributes =
            @{NSForegroundColorAttributeName : _stageColor, NSFontAttributeName : _stageFont};

        [sep drawAtPoint:CGPointMake(posX, kMargin_Top + CGRectGetHeight(self.bounds) / 4)
            withAttributes:attributes];
        [value drawAtPoint:CGPointMake(posX, 3 * kMargin_Top + CGRectGetHeight(self.bounds) / 4)
            withAttributes:attributes];
    }
}

#pragma mark
#pragma mark Getter

- (CGFloat)thumbWidth
{
    if (_thumbWidth == 0)
    {
        _thumbWidth = CGRectGetHeight(self.bounds) / 2;
    }
    return _thumbWidth;
}

- (CGFloat)thumbHeight
{
    if (_thumbHeight == 0)
    {
        _thumbHeight = self.thumbWidth;
    }
    return _thumbHeight;
}

#pragma mark
#pragma mark Setter
- (void)setMinValue:(CGFloat)minValue
{
    _minValue = minValue;
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)setMaxValue:(CGFloat)maxValue
{
    _maxValue = maxValue;
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)setLeftValue:(CGFloat)leftValue
{
    _leftValue = leftValue;
    [self setNeedsLayout];
    if (_valueChangeBlock)
    {
        _valueChangeBlock(_leftValue, _rightValue);
    }
}

- (void)setRightValue:(CGFloat)rightValue
{
    _rightValue = rightValue;
    [self setNeedsLayout];
    if (_valueChangeBlock)
    {
        _valueChangeBlock(_leftValue, _rightValue);
    }
}

- (void)setMargin:(CGFloat)margin
{
    _margin = margin;
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)setStageValue:(CGFloat)stageValue
{
    _stageValue = stageValue;
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)setStageSelectedOnly:(BOOL)stageSelectedOnly
{
    _stageSelectedOnly = stageSelectedOnly;
    [self setNeedsLayout];
}

- (void)setStageColor:(UIColor *)stageColor
{
    _stageColor = stageColor;
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)setStageFont:(UIFont *)stageFont
{
    _stageFont = stageFont;
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)setThumbColor:(UIColor *)thumbColor
{
    _thumbColor = thumbColor;
    [_leftThumbLayer setNeedsDisplay];
    [_rightThumbLayer setNeedsDisplay];
}

- (void)setTrackColor:(UIColor *)trackColor
{
    _trackColor = trackColor;
    [_trackLayer setNeedsDisplay];
}

- (void)setTrackHighlightTintColor:(UIColor *)trackHighlightTintColor
{
    _trackHighlightTintColor = trackHighlightTintColor;
    [_trackLayer setNeedsDisplay];
}

#pragma mark
#pragma mark Touch

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    _previousLocation = [touch locationInView:self];
    if (CGRectContainsPoint(_leftThumbLayer.frame, _previousLocation))
    {
        _leftThumbLayer.highlighted = YES;
    }
    else if (CGRectContainsPoint(_rightThumbLayer.frame, _previousLocation))
    {
        _rightThumbLayer.highlighted = YES;
    }
    return _leftThumbLayer.highlighted || _rightThumbLayer.highlighted;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:self];
    CGFloat deltaX = point.x - _previousLocation.x;
    CGFloat percentage = deltaX / (CGRectGetWidth(self.bounds) - _margin * 2);
    CGFloat deltaValue = (_maxValue - _minValue) * percentage;
    _previousLocation = point;
    if (_leftThumbLayer.highlighted)
    {
        _leftValue += deltaValue;
        self.leftValue = [self boundaryForValue:_leftValue minValue:_minValue maxValue:_rightValue];
    }
    else if (_rightThumbLayer.highlighted)
    {
        self.rightValue += deltaValue;
        self.rightValue =
            [self boundaryForValue:_rightValue minValue:_leftValue maxValue:_maxValue];
    }
    CGFloat minRange = [self valueForWidth:_thumbWidth];
    minRange = MAX(minRange, _stageValue);
    if ((_rightValue - _leftValue) < minRange)
    {
        if (_leftThumbLayer.highlighted)
        {
            _leftValue = _rightValue - minRange;
        }
        else if (_rightThumbLayer.highlighted)
        {
            _rightValue = _leftValue + minRange;
        }
    }
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (_leftThumbLayer.highlighted)
    {
        CGFloat endValue;
        if (_stageSelectedOnly)
        {
            endValue = lrint(_leftValue / _stageValue) * _stageValue;
        }
        else
        {
            endValue = (_leftValue / _stageValue) * _stageValue;
        }
        self.leftValue = [self boundaryForValue:endValue minValue:_minValue maxValue:_rightValue];
    }
    else if (_rightThumbLayer.highlighted)
    {
        CGFloat endValue;
        if (_stageSelectedOnly)
        {
            endValue = lrint(_rightValue / _stageValue) * _stageValue;
        }
        else
        {
            endValue = (_rightValue / _stageValue) * _stageValue;
        }
        self.rightValue = [self boundaryForValue:endValue minValue:_leftValue maxValue:_maxValue];
    }
    _leftThumbLayer.highlighted = NO;
    _rightThumbLayer.highlighted = NO;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    _leftThumbLayer.highlighted = NO;
    _rightThumbLayer.highlighted = NO;
}

@end

#pragma mark
#pragma mark HDRangeSliderTrackLayer

@implementation HDRangeSliderTrackLayer

- (void)drawInContext:(CGContextRef)ctx
{
    if (_rangeSlider)
    {
        CGFloat cornorRadius = CGRectGetHeight(self.bounds) / 2.0;
        UIBezierPath *path =
            [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornorRadius];
        CGContextAddPath(ctx, path.CGPath);
        CGContextSetFillColorWithColor(ctx, _rangeSlider.trackColor.CGColor);
        CGContextFillPath(ctx);

        CGContextSetFillColorWithColor(ctx, _rangeSlider.trackHighlightTintColor.CGColor);
        CGFloat leftValuePosition = [_rangeSlider positionForValue:_rangeSlider.leftValue];
        CGFloat rightValuePosition = [_rangeSlider positionForValue:_rangeSlider.rightValue];
        CGRect rect = CGRectMake(leftValuePosition, 0.0, rightValuePosition - leftValuePosition,
                                 CGRectGetHeight(self.bounds));
        CGContextFillRect(ctx, rect);
    }
}

@end

#pragma mark
#pragma mark HDRangeSliderThumbLayer

@implementation HDRangeSliderThumbLayer

#pragma mark
#pragma mark Render

- (void)drawInContext:(CGContextRef)ctx
{
    if (_rangeSlider)
    {
        CGRect tempFrame = CGRectInset(self.bounds, 0, 0);
        CGFloat cornorRadius = CGRectGetHeight(self.bounds) / 2;
        UIBezierPath *path =
            [UIBezierPath bezierPathWithRoundedRect:tempFrame cornerRadius:cornorRadius];
        CGContextSetFillColorWithColor(ctx, _rangeSlider.thumbColor.CGColor);
        CGContextAddPath(ctx, path.CGPath);
        CGContextFillPath(ctx);

        if (_highlighted)
        {
            CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:0.0 alpha:0.1].CGColor);
            CGContextAddPath(ctx, path.CGPath);
            CGContextFillPath(ctx);
        }
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    [self setNeedsDisplay];
}

@end

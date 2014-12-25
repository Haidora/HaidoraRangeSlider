//
//  ViewController.m
//  HaidoraRangeSlider
//
//  Created by DaiLingchi on 14-10-19.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import "ViewController.h"
#import "HDRangeSlider.h"

@interface ViewController ()

@property (nonatomic, strong) HDRangeSlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _slider = [[HDRangeSlider alloc] initWithFrame:CGRectMake(50, 50, 200, 31)];
    _slider.valueChangeBlock = ^(CGFloat x, CGFloat y) { NSLog(@"%@-%@", @(x), @(y)); };
    //	slider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _slider.minValue = 0;
    _slider.maxValue = 800;
    //	_slider.stageValue = 100;
    _slider.leftValue = 0;
    _slider.rightValue = 800;
    //	_slider.margin = 25;
    [self.view addSubview:_slider];
}
- (IBAction)getValue:(id)sender
{
    NSLog(@"left:%f  right:%f", _slider.leftValue, _slider.rightValue);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  SegmentedProgressBar
//
//  Created by kurtu on 9/14/15.
//  Copyright © 2015 kurtu. All rights reserved.
//

#import "SegmentedProgressBar.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SegmentedProgressBar *segmentedProgressBar = [[SegmentedProgressBar alloc] initWithFrame:CGRectMake(10, 50, 180, 20)];
    segmentedProgressBar.segmentColor = [UIColor blueColor];
    
    
    [self.view addSubview:segmentedProgressBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

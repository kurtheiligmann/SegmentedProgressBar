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
@property (nonatomic, strong) IBOutlet SegmentedProgressBar *segmentedProgressBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.segmentedProgressBar = [[SegmentedProgressBar alloc] initWithFrame:CGRectMake(10, 50, 180, 10)];
    self.segmentedProgressBar.completedSegmentColor = [UIColor blueColor];
    self.segmentedProgressBar.segmentColor = [self.segmentedProgressBar.completedSegmentColor colorWithAlphaComponent:0.4];
    self.segmentedProgressBar.numberOfSegments = 8;
    self.segmentedProgressBar.numberOfCompletedSegments = 3;
    
    [self.view addSubview:self.segmentedProgressBar];
}

- (IBAction)segButtonPressed {
    self.segmentedProgressBar.numberOfCompletedSegments += 1;
}

- (IBAction)colorButtonPressed {
    self.segmentedProgressBar.segmentColor = [UIColor purpleColor];
}

@end

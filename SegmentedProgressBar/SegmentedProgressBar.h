//
//  SegmentedProgressBar.h
//  SegmentedProgressBar
//
//  Created by kurtu on 9/14/15.
//  Copyright © 2015 kurtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentedProgressBar : UIView

@property (nonatomic, strong) UIColor *segmentColor;
@property (nonatomic, strong) UIColor *completedSegmentColor;
@property (nonatomic) NSInteger numberOfSegments;
@property (nonatomic) NSInteger numberOfCompletedSegments;

@end

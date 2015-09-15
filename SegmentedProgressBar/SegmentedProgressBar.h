//
//  SegmentedProgressBar.h
//  SegmentedProgressBar
//
//  Created by kurtu on 9/14/15.
//  Copyright © 2015 kurtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentedProgressBar : UIView

@property (nonatomic, strong) IBInspectable UIColor *segmentColor;
@property (nonatomic, strong) IBInspectable UIColor *completedSegmentColor;
@property (nonatomic) IBInspectable NSInteger numberOfSegments;
@property (nonatomic) IBInspectable NSInteger numberOfCompletedSegments;

@end

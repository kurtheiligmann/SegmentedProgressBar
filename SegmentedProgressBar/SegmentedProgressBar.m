//
//  SegmentedProgressBar.m
//  SegmentedProgressBar
//
//  Created by ;;; on 9/14/15.
//  Copyright © 2015 kurtu. All rights reserved.
//

#import "SegmentedProgressBar.h"

@implementation SegmentedProgressBar

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeDefaults];
        [self updateSegments];
    }
    
    return self;
}

#pragma mark - SegmentedProgressBar

- (void)setSegmentColor:(UIColor *)segmentColor {
    _segmentColor = segmentColor;
    [self updateSegments];
}

- (void)setCompletedSegmentColor:(UIColor *)completedSegmentColor {
    _completedSegmentColor = completedSegmentColor;
    [self updateSegments];
}

- (void)setSegmentSeperatorWidth:(CGFloat)segmentSeperatorWidth {
    _segmentSeperatorWidth = segmentSeperatorWidth;
    [self updateSegments];
}

- (void)setNumberOfSegments:(NSInteger)numberOfSegments {
    _numberOfSegments = numberOfSegments;
    [self updateSegments];
}

- (void)setNumberOfCompletedSegments:(NSInteger)numberOfCompletedSegments {
    _numberOfCompletedSegments = numberOfCompletedSegments;
    [self updateSegments];
}

#pragma mark - Private Methods

- (void)initializeDefaults {
    self.backgroundColor = [UIColor clearColor];
    _segmentSeperatorWidth = 2.0;
    _numberOfSegments = 3;
    _numberOfCompletedSegments = 0;
    _completedSegmentColor = [UIColor blueColor];
    _segmentColor = [_completedSegmentColor colorWithAlphaComponent:0.4];
}

- (void)updateSegments {
    [self removeSubviews];
    
    CGFloat segmentWidth = (self.bounds.size.width - ((self.numberOfSegments - 1) * self.segmentSeperatorWidth)) / self.numberOfSegments;
    
    for (NSInteger i = 0; i < self.numberOfSegments; i++) {
        UIView *segment = [[UIView alloc] initWithFrame:CGRectMake(i * (segmentWidth + self.segmentSeperatorWidth), 0, segmentWidth, self.bounds.size.height)];
        if (i < self.numberOfCompletedSegments) {
            segment.backgroundColor = self.completedSegmentColor;
        } else {
            segment.backgroundColor = self.segmentColor;
        }
        
        if (i == 0) {
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:segment.bounds
                                                             byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                                   cornerRadii:CGSizeMake(segment.frame.size.height / 2, segment.frame.size.height / 2)];
            CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
            shapeLayer.frame = segment.bounds;
            shapeLayer.path = bezierPath.CGPath;
            segment.layer.mask = shapeLayer;
        } else if (i == (self.numberOfSegments - 1)) {
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:segment.bounds
                                                             byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                                   cornerRadii:CGSizeMake(segment.frame.size.height / 2, segment.frame.size.height / 2)];
            CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
            shapeLayer.frame = segment.bounds;
            shapeLayer.path = bezierPath.CGPath;
            segment.layer.mask = shapeLayer;
        }
        
        [self addSubview:segment];
    }
}

- (void)removeSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

@end

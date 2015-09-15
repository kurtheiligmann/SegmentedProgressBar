//
//  SegmentedProgressBar.m
//  SegmentedProgressBar
//
//  Created by ;;; on 9/14/15.
//  Copyright © 2015 kurtu. All rights reserved.
//

#import "SegmentedProgressBar.h"

static CGFloat const kSegmentSeperatorWidth = 4.0;

@interface SegmentedProgressBar ()

@property (nonatomic, strong) NSArray *segmentViews;

@end

@implementation SegmentedProgressBar

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.numberOfSegments = 3;
        [self updateSegments];
    }
    
    return self;
}

- (void)updateSegments {
    [self removeSubviews];
    
    CGFloat segmentWidth = (self.bounds.size.width - ((self.numberOfSegments - 1) * kSegmentSeperatorWidth)) / self.numberOfSegments;
    
    for (NSInteger i = 0; i < self.numberOfSegments; i++) {
        UIView *segment = [[UIView alloc] initWithFrame:CGRectMake(i * (segmentWidth + kSegmentSeperatorWidth), 0, segmentWidth, self.bounds.size.height)];
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

- (void)setSegmentColor:(UIColor *)segmentColor {
    _segmentColor = segmentColor;
    [self updateSegments];
}

- (void)setCompletedSegmentColor:(UIColor *)completedSegmentColor {
    _completedSegmentColor = completedSegmentColor;
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

- (void)removeSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

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

- (id)init {
    if (self = [super init]) {
        [self initializeDefaults];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeDefaults];
    }
    
    return self;
}

- (void)layoutSubviews {
    [self updateSegments];
}

#pragma mark - SegmentedProgressBar

- (void)setSegmentColor:(UIColor *)segmentColor {
    _segmentColor = segmentColor;
    [self setNeedsLayout];
}

- (void)setCompletedSegmentColor:(UIColor *)completedSegmentColor {
    _completedSegmentColor = completedSegmentColor;
    [self setNeedsLayout];
}

- (void)setSegmentSeperatorWidth:(CGFloat)segmentSeperatorWidth {
    _segmentSeperatorWidth = segmentSeperatorWidth;
    [self setNeedsLayout];
}

- (void)setNumberOfSegments:(NSInteger)numberOfSegments {
    _numberOfSegments = numberOfSegments;
    [self setNeedsLayout];
}

- (void)setNumberOfCompletedSegments:(NSInteger)numberOfCompletedSegments {
    _numberOfCompletedSegments = numberOfCompletedSegments;
    [self setNeedsLayout];
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
    if (!CGRectEqualToRect(self.bounds, CGRectZero)) {
        [self removeSubviews];
        
        CGFloat segmentWidth = MAX((self.bounds.size.width - ((self.numberOfSegments - 1) * self.segmentSeperatorWidth)) / self.numberOfSegments, 0);
        
        UIView *previousSegment = nil;
        for (NSInteger i = 0; i < self.numberOfSegments; i++) {
            UIView *segment = [[UIView alloc] initWithFrame:CGRectMake(0, 0, segmentWidth, self.bounds.size.height)];
            segment.translatesAutoresizingMaskIntoConstraints = NO;
            if (i < self.numberOfCompletedSegments) {
                segment.backgroundColor = self.completedSegmentColor;
            } else {
                segment.backgroundColor = self.segmentColor;
            }
            
            [self addSubview:segment];
            
            static NSString *segmentId = @"segment";
            static NSString *previousSegmentId = @"previousSegment";
            NSArray *hConstraints = nil;
            if (i == 0) {
                NSString *hFormat = [NSString stringWithFormat:@"H:|[%@(%f)]", segmentId, segmentWidth];
                hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hFormat
                                                                       options:kNilOptions
                                                                       metrics:nil
                                                                         views:@{segmentId : segment}];
                
                UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:segment.bounds
                                                                 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                                       cornerRadii:CGSizeMake(segment.frame.size.height / 2, segment.frame.size.height / 2)];
                CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
                shapeLayer.frame = segment.bounds;
                shapeLayer.path = bezierPath.CGPath;
                segment.layer.mask = shapeLayer;
            } else if (i == (self.numberOfSegments - 1)) {
                NSString *hFormat = [NSString stringWithFormat:@"H:[%@]-%f-[%@(%f)]|",previousSegmentId, self.segmentSeperatorWidth, segmentId, segmentWidth];
                hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hFormat
                                                                       options:kNilOptions
                                                                       metrics:nil
                                                                         views:@{previousSegmentId : previousSegment,
                                                                                 segmentId : segment}];
                
                UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:segment.bounds
                                                                 byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                                       cornerRadii:CGSizeMake(segment.frame.size.height / 2, segment.frame.size.height / 2)];
                CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
                shapeLayer.frame = segment.bounds;
                shapeLayer.path = bezierPath.CGPath;
                segment.layer.mask = shapeLayer;
            } else {
                NSString *hFormat = [NSString stringWithFormat:@"H:[%@]-%f-[%@(%f)]",previousSegmentId, self.segmentSeperatorWidth, segmentId, segmentWidth];
                hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hFormat
                                                                       options:kNilOptions
                                                                       metrics:nil
                                                                         views:@{previousSegmentId : previousSegment,
                                                                                 segmentId : segment}];
                
            }
            
            for (NSLayoutConstraint *hConstraint in hConstraints) {
                hConstraint.priority = UILayoutPriorityDefaultLow;
            }
            
            [self addConstraints:hConstraints];
            
            NSString *vFormat = [NSString stringWithFormat:@"V:|[%@]|", segmentId];
            NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vFormat
                                                                            options:kNilOptions
                                                                            metrics:nil
                                                                              views:@{segmentId : segment}];
            [self addConstraints:vConstraints];
            
            
            previousSegment = segment;
        }
    }
}

- (void)removeSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

@end

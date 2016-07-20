//
//  SDRotationLoopProgressView.m
//  SDProgressView
//
//  Created by aier on 15-2-20.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDRotationLoopProgressView.h"



@implementation SDRotationLoopProgressView
{
    CGFloat _angleInterval;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(changeAngle) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)changeAngle
{
//    _angleInterval += M_PI * 0.08;
//    if (_angleInterval >= M_PI * 2) _angleInterval = 0;
//    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    [[UIColor orangeColor] set];
    
    CGContextSetLineWidth(ctx, 3);
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - SDProgressViewItemMargin;
    CGContextAddArc(ctx, xCenter, yCenter, radius, 0, 2*M_PI, NO);
    CGContextStrokePath(ctx);
    
    
    CGContextRef ctx2 = UIGraphicsGetCurrentContext();
    CGFloat xCenter2 = rect.size.width * 0.5;
    CGFloat yCenter2 = rect.size.height * 0.5;
    [[UIColor lightGrayColor] set];
    
    CGContextSetLineWidth(ctx2, 3);
    CGFloat radius2 = MIN(rect.size.width * 0.5, rect.size.height * 0.5) - SDProgressViewItemMargin;
    CGContextAddArc(ctx2, xCenter2, yCenter2, radius2, -0.5*M_PI,-0.5*M_PI+self.progress*M_PI*2, 0);
    CGContextStrokePath(ctx2);
    
    
    CGContextRef ctx3 = UIGraphicsGetCurrentContext();
    CGFloat xCenter3 = (rect.size.width) * 0.5;
    CGFloat yCenter3 = (rect.size.height) * 0.5;
    [[UIColor orangeColor] set];
    
    CGContextSetLineWidth(ctx3, 14);
    CGFloat radius3 = rect.size.width * 0.5 - SDProgressViewItemMargin;
    CGContextAddArc(ctx3, xCenter3, yCenter3, radius3, -0.5*M_PI+self.progress*M_PI*2,-0.5*M_PI+0.1/M_PI+self.progress*M_PI*2, 0);
    CGContextStrokePath(ctx3);
    // 加载时显示的文字
    NSString * const SDRotationLoopProgressViewWaitingText = [NSString stringWithFormat:@"%.0f%%",100-self.progress*100];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:13 * SDProgressViewFontScale];
    attributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [self setCenterProgressText:SDRotationLoopProgressViewWaitingText withAttributes:attributes];
    
    NSAttributedString *attrStr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f%%",self.progress*100] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor orangeColor]}];
    [attrStr2 drawAtPoint:CGPointMake(xCenter3-12+(radius3+21)*cos(-0.5*M_PI+self.progress*M_PI*2), yCenter3-7+(radius3+15)*sin(-0.5*M_PI+self.progress*M_PI*2))];
}

@end

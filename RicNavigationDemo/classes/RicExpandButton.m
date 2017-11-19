//
//  RicExpandButton.m
//  Kuoke
//
//  Created by Rice on 2017/11/9.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicExpandButton.h"

@implementation RicExpandButton
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGFloat demenssion = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    if(demenssion > 44){
        return [super pointInside:point withEvent:event];
    }else{
        CGRect bounds = self.bounds;
        //若原热区小于44x44，则放大热区，否则保持原大小不变
        CGFloat touchAreaRadius = 44.0f;
        CGFloat widthDelta = MAX(touchAreaRadius - bounds.size.width, 0);
        CGFloat heightDelta = MAX(touchAreaRadius - bounds.size.height, 0);
        bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
        return CGRectContainsPoint(bounds, point);
    }
}
@end

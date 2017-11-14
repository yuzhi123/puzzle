//
//  UILabel+ExtraDistance.m
//  label添加左右间隙
//
//  Created by kejunapple on 2017/10/23.
//  Copyright © 2017年 kejunapple. All rights reserved.
//

#import "UILabel+ExtraWidth.h"

#import <objc/runtime.h>

@implementation UILabel (ExtraWidth)


+ (void)load {
    
    Method original = class_getInstanceMethod(self, @selector(intrinsicContentSize));
    Method swizzle = class_getInstanceMethod(self, @selector(xx_intrinsicContentSize));
    
    method_exchangeImplementations(original, swizzle);
    
}


- (CGFloat)extraWidth {
    return [objc_getAssociatedObject(self, @selector(extraWidth)) doubleValue];
}
- (void)setExtraWidth:(CGFloat)extraWidth {
    objc_setAssociatedObject(self, @selector(extraWidth), @(extraWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self invalidateIntrinsicContentSize];
    
}

- (CGSize)xx_intrinsicContentSize {
    CGSize size = [self xx_intrinsicContentSize];
    CGFloat extraWidth = self.extraWidth;
    size.width += extraWidth;
    return size;
    
}

@end

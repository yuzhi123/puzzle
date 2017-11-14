//
//  UITextField+ExtenRange.m
//  FeiHangChuangKe
//
//  Created by 王飞 on 17/3/6.
//  Copyright © 2017年 FeiHangKeJi.com. All rights reserved.
//

#import "UITextField+ExtenRange.h"

@implementation UITextField (ExtenRange)







-(NSRange)selectedRange
{
    UITextPosition* begining = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    
    UITextPosition* selectionStart = selectedRange.start;
    
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:begining toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

-(void)setSelectedRange:(NSRange)range
{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
    
}

@end

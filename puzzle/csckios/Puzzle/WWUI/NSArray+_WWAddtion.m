//
//  NSArray+_WWAddtion.m
//  FeiHangChuangKe
//
//  Created by 王飞 on 17/1/5.
//  Copyright © 2017年 FeiHangKeJi.com. All rights reserved.
//

#import "NSArray+_WWAddtion.h"

@implementation NSArray (_WWAddtion)

-(BOOL)isEqualToContent:(NSArray*)array
{
    if (array.count == self.count) {
        
        NSMutableArray* array1 = [NSMutableArray array];
        NSMutableArray* array2 = [NSMutableArray array];
        for (int i=0 ;i<array.count ; i++) {
            [array1 addObject:array[i]];
            [array2 addObject:self[i]];
        }
 
      
            for (int i = 0; i<array1.count; i++) {
                for (int j=0; j<array2.count; j++) {
                    
                    if ([array1[j]isEqualToString:array2[i] ] ) {
                        [array1 removeObjectAtIndex:j];
                        [array2 removeObjectAtIndex:i];
                        i--;
                        j=-1;
                        break;
                    }
                }
            }
        
        if (array1.count == 0) {
            return YES;
        }
        else
        {
            return NO;
        }
        
    }
    else
    {
        return NO;
    }
    
}

-(NSString*)toJsonStr
{
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}

@end

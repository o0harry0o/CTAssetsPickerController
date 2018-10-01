//
//  PHAsset+CTPHAsset.m
//  CTAssetsPickerDemo
//
//  Created by チャン ビングエン on 2018/10/02.
//  Copyright © 2018 Clement T. All rights reserved.
//

#import "PHAsset+CTPHAsset.h"
#import <objc/runtime.h>
@implementation PHAsset (CTPHAsset)
- (void)setFileSize:(long long)fileSize{
    objc_setAssociatedObject(self, @selector(fileSize), [NSNumber numberWithLongLong:fileSize], OBJC_ASSOCIATION_ASSIGN);
}
- (long long)fileSize{
    NSNumber * number =  objc_getAssociatedObject(self, @selector(fileSize));
    return number.longLongValue;
}
@end

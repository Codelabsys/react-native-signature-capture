//
//  RSSignatureView+OnStartDrag.m
//  RSSignatureCapture
//
//  Created by MohamedAbbas on 9/20/18.
//  Copyright © 2018 RepairShopr. All rights reserved.
//


#import "RSSignatureView+OnStartDrag.h"
#import <objc/runtime.h>

@implementation RSSignatureView (OnStartDrag)

static void * OnStartDragKey;
- (RCTBubblingEventBlock) onStartDrag
{
    return objc_getAssociatedObject(self, &OnStartDragKey);
}

- (void) setOnStartDrag:(RCTBubblingEventBlock)onStartDrag
{
    objc_setAssociatedObject(self, &OnStartDragKey, onStartDrag, OBJC_ASSOCIATION_COPY);
}
@end


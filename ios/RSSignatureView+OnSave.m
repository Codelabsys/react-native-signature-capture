//
//  RSSignatureView+OnSave.m
//  RSSignatureCapture
//
//  Created by MohamedAbbas on 9/20/18.
//  Copyright © 2018 RepairShopr. All rights reserved.
//

#import "RSSignatureView+OnSave.h"
#import <objc/runtime.h>

@implementation RSSignatureView (OnSave)

static void * OnSaveKey;
- (RCTBubblingEventBlock) onSave
{
    return objc_getAssociatedObject(self, &OnSaveKey);
}

- (void) setOnSave:(RCTBubblingEventBlock)onSave
{
    objc_setAssociatedObject(self, &OnSaveKey, onSave, OBJC_ASSOCIATION_COPY);
}

@end

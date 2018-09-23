//
//  RSSignatureView+OnStartDrag.h
//  RSSignatureCapture
//
//  Created by MohamedAbbas on 9/20/18.
//  Copyright © 2018 RepairShopr. All rights reserved.
//


#import "RSSignatureView.h"
#import <React/RCTComponent.h>

@interface RSSignatureView (OnStartDrag)

- (RCTBubblingEventBlock) onStartDrag;
- (void) setOnStartDrag:(RCTBubblingEventBlock)onStartDrag;

@end


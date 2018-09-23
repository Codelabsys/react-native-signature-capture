#import "RSSignatureViewManager.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import <RCTUIManager.h>
#import "RSSignatureView+OnSave.h"
#import "RSSignatureView+OnStartDrag.h"

@implementation RSSignatureViewManager

@synthesize bridge = _bridge;
@synthesize signView;

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(rotateClockwise, BOOL)
RCT_EXPORT_VIEW_PROPERTY(square, BOOL)
RCT_EXPORT_VIEW_PROPERTY(showNativeButtons, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onSave, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onStartDrag, RCTBubblingEventBlock)

-(dispatch_queue_t) methodQueue
{
	return dispatch_get_main_queue();
}

-(UIView *) view
{
	self.signView = [[RSSignatureView alloc] init];
	self.signView.manager = self;
	return signView;
}

// Both of these methods needs to be called from the main thread so the
// UI can clear out the signature.
RCT_EXPORT_METHOD(saveImage:(nonnull NSNumber *)reactTag) {
	dispatch_async(dispatch_get_main_queue(), ^{
        RSSignatureView * signView = (RSSignatureView*)[self.bridge.uiManager viewForReactTag:reactTag];
        [signView saveImage];
	});
}

RCT_EXPORT_METHOD(resetImage:(nonnull NSNumber *)reactTag) {
	dispatch_async(dispatch_get_main_queue(), ^{
        RSSignatureView * signView = (RSSignatureView*)[self.bridge.uiManager viewForReactTag:reactTag];
        [signView erase];
	});
}

-(void) publishSaveImageEventWithSignatureView:(RSSignatureView *)signView path:(NSString *) aTempPath encoded: (NSString *) aEncoded {
    signView.onSave(@{
                      @"pathName": aTempPath,
                      @"encoded": aEncoded
                      });
}

-(void) publishDraggedEventWithSignatureView:(RSSignatureView *)signView {
    signView.onStartDrag(@{
                           @"dragged": @YES
                           });
}



@end

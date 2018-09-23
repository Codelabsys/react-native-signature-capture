#import "RSSignatureView.h"
#import <React/RCTViewManager.h>

@interface RSSignatureViewManager : RCTViewManager
@property (nonatomic, strong) RSSignatureView *signView;
-(void) saveImage:(nonnull NSNumber *)reactTag;
-(void) resetImage:(nonnull NSNumber *)reactTag;
-(void) publishSaveImageEventWithSignatureView:(RSSignatureView *)signView path:(NSString *) aTempPath encoded: (NSString *) aEncoded;
-(void) publishDraggedEventWithSignatureView:(RSSignatureView *)signView;
@end

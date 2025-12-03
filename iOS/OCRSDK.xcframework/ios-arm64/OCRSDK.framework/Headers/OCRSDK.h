#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCRSDK : NSObject

- (instancetype)initWithPreview:(UIViewController *)viewController;
- (instancetype)initWithPreview;

- (void)startRecognize:(void (^)(NSMutableArray<NSString *> *resultArray, UIImage *processedImage))completion;

@property (nonatomic, strong) UIView *detectBox;
@property(nonatomic, assign) int frameCount;

// Thread & processing state
@property (nonatomic, strong) dispatch_queue_t detectionQueue; // detection queue
@property (nonatomic, assign) BOOL isProcessing; // is currently processing a frame
@property (nonatomic, copy) void (^completionHandler)(NSMutableArray<NSString *> *resultArray, UIImage *processedImage);

+ (NSString *)modelPathWithName:(NSString *)name extension:(NSString *)ext;

@end

NS_ASSUME_NONNULL_END

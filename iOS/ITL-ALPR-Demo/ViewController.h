#import <UIKit/UIKit.h>
#import <OCRSDK/OCRSDK.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) UIButton *recognizeButton;
@property (nonatomic, strong) OCRSDK *sdk;
@end

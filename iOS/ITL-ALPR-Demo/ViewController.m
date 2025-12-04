#import "ViewController.h"
#define kPrimaryOrange [UIColor colorWithRed:1.0 green:0.58 blue:0.0 alpha:1.0]

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupButton];
    self.sdk = [[ITLALPR alloc] initWithPreview:self];
}
- (void)setupButton {
    self.recognizeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.recognizeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.recognizeButton setTitle:@"SCAN" forState:UIControlStateNormal];
    [self.recognizeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.recognizeButton.backgroundColor = kPrimaryOrange;
    self.recognizeButton.layer.cornerRadius = 8.0;
    self.recognizeButton.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    self.recognizeButton.layer.shadowColor = kPrimaryOrange.CGColor;
    self.recognizeButton.layer.shadowOpacity = 0.2;
    self.recognizeButton.layer.shadowRadius = 6.0;
    self.recognizeButton.layer.shadowOffset = CGSizeMake(0, 3);
    self.recognizeButton.adjustsImageWhenHighlighted = NO;
    [self.recognizeButton addTarget:self action:@selector(recognizeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.recognizeButton addTarget:self action:@selector(buttonHighlighted:) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self.recognizeButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel | UIControlEventTouchDragExit];
    [self.view addSubview:self.recognizeButton];
    [self.view bringSubviewToFront:self.recognizeButton];
    [NSLayoutConstraint activateConstraints:@[
        [self.recognizeButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:30],
        [self.recognizeButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-30],
        [self.recognizeButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.recognizeButton.heightAnchor constraintEqualToConstant:52]
    ]];
}
- (void)buttonHighlighted:(UIButton *)sender {
    sender.backgroundColor = [kPrimaryOrange colorWithAlphaComponent:0.7];
}
- (void)buttonNormal:(UIButton *)sender {
    sender.backgroundColor = kPrimaryOrange;
}
- (void)recognizeButtonTapped {
    [self.sdk startRecognize:^(NSMutableArray<NSString *> *resultArray, UIImage *processedImage) {
        NSString *state = (resultArray.count > 0) ? resultArray[0] : @"Not recognized";
        NSString *plate = (resultArray.count > 1) ? resultArray[1] : @"Not recognized";
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Identification result"
                                                                           message:[NSString stringWithFormat:@"State: %@\nPlate: %@", state, plate]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}
@end

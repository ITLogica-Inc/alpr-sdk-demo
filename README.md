#  1. ITL-ALPR-SDK Android Integration Guide

<details open>
<summary>Add SDK Dependency</summary>

   - Place the `itlalpr-sdk.aar` file into your project's `app/libs/` directory.

   - Add the following dependency in your `app/build.gradle.kts` file:
     ```kotlin
     implementation(files("libs/itlalpr-sdk.aar"))
     ```
</details>

<details open>
<summary>Register and Launch License Plate Recognition Activity</summary>

   - In the `onCreate` method of `MainActivity`, register the launcher for `CameraActivity`:
     ```kotlin
     cameraResultLauncher = registerForActivityResult(
         ActivityResultContracts.StartActivityForResult()
     ) { result ->
         if (result.resultCode == RESULT_OK) {
             // Process recognition results
         }
     }
     ```
   - Launch the license plate recognition activity via a button or other UI element:
     ```kotlin
     val intent = Intent(this, CameraActivity::class.java)
     cameraResultLauncher.launch(intent)
     ```
</details>

<details open>
<summary>Obtain Recognition Results</summary>

- After recognition, get the results from `ScanResultCache`:
     ```kotlin
     val state = ScanResultCache.recognizedState
     val no = ScanResultCache.recognizedNo
     if (!state.isNullOrEmpty() || !no.isNullOrEmpty()) {
         // Recognition succeeded, handle results
     } else {
         // Recognition failed or not registered
     }
     // Clear cache
     ScanResultCache.recognizedState = null
     ScanResultCache.recognizedNo = null
     ```   

</details>

---

# 2. ITL-ALPR-SDK IOS Integration Guide

<details open>
<summary>Add SDK to Project</summary>

  - Add the `ITLALPR.xcframework` folder to the root directory of your Xcode project, and include it in Frameworks, Libraries, and Embedded Content in your project settings.

  - Import the header file in the class where you need to use the SDK:
     ```objective-c
     #import <ITLALPR/ITLALPR.h>
     ```
</details>

<details open>
<summary>Initialize SDK</summary>

   - Create an ITLALPR instance in your view controller and pass in the preview view controller (usually self):
```objective-c
self.sdk = [[ITLALPR alloc] initWithPreview:self];
```
</details>

<details open>
<summary>Start Recognition</summary>

   - Call the `startRecognize` method to start license plate recognition:
```objective-c
[self.sdk startRecognize:^(NSMutableArray<NSString *> *resultArray, UIImage *processedImage) {
    // Handle recognition results
}];
```

- `resultArray`: Array of recognition results, usually the first element is the state name, and the second is the license plate number.
- `processedImage`: The processed image, which can be displayed or saved.

</details>

<details open>
<summary> Handling Recognition Results</summary>

   - It is recommended to update the UI on the main thread in the callback, such as showing a popup with the recognition results:
```objective-c
dispatch_async(dispatch_get_main_queue(), ^{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Recognition Result"
                                                                   message:[NSString stringWithFormat:@"State: %@\nPlate: %@", state, plate]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
});
```
</details>

<details open>
<summary>Resource File Description</summary>

   
```objective-c
#import <ITLALPR/ITLALPR.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) ITLALPR *sdk;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.sdk = [[ITLALPR alloc] initWithPreview:self];
}
- (void)recognizeButtonTapped {
    [self.sdk startRecognize:^(NSMutableArray<NSString *> *resultArray, UIImage *processedImage) {
        NSString *state = (resultArray.count > 0) ? resultArray[0] : @"Unrecognized";
        NSString *plate = (resultArray.count > 1) ? resultArray[1] : @"Unrecognized";
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Recognition Result"
                                                                           message:[NSString stringWithFormat:@"State: %@\nPlate: %@", state, plate]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}
@end
```
</details>


---
# 3. Contact
- Official Website: [https://alpr-sdk.itlogica.net/](https://alpr-sdk.itlogica.net/)
- Email: alpr-sdk@itlogica.com

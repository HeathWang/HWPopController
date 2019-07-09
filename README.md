# HWPopController

<p style="align: left">
    <a href="https://cocoapods.org/pods/HWPopController">
       <img src="https://img.shields.io/cocoapods/v/HWPopController.svg?style=flat">
    </a>
    <a href="https://cocoapods.org/pods/HWPopController">
       <img src="https://img.shields.io/cocoapods/p/HWPopController.svg?style=flat">
    </a>
    <a href="https://cocoapods.org/pods/HWPopController">
       <img src="https://img.shields.io/badge/support-ios%208%2B-orange.svg">
    </a>
    <a href="https://cocoapods.org/pods/HWPopController">
       <img src="https://img.shields.io/badge/language-objective--c-blue.svg">
    </a>
    <a href="https://cocoapods.org/pods/HWPopController">
       <img src="https://img.shields.io/cocoapods/l/HWPopController.svg?style=flat">
    </a>
    <a href="https://cocoapods.org/pods/HWPopController">
       <img src="https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=plastic">
    </a>
</p>

`HWPopController` can popup `UIViewController` with `multiple animations`, custom pop size in portrait / landscape screen. Popup position can be `top/center/bottom`. And you can define your own popup animations.

**My another project for pop view from bottom:**[**HWPanModal**](https://github.com/HeathWang/HWPanModal)

## Screen Shot

<div style="text-align: center"><table><tr>
<td style="text-align: center">
<img src="https://github.com/HeathWang/HWPopController/blob/master/screenshoot1.gif" width="250" />
</td>
<td style="text-align: center">
<img src="https://github.com/HeathWang/HWPopController/blob/master/screenshoot2.gif" width="250"/>
</td>
<td style="text-align: center">
<img src="https://github.com/HeathWang/HWPopController/blob/master/screenshoot3.gif" width="250"/>
</td>
</tr></table></div>

## Features
* Support popup UIViewController.
* Support popup UINavigationController, dynamic change pop size when you push/pop.
* Support 12 kinds of pop & dismiss animations.
* Support define your own custom animation for pop & dismiss.
* Support popup at top/center/bottom, and use `positionOffset` to adjust x,y coordinates.

## Compatibility
**iOS 8.0+**, support Objective-C & Swift.

## Installation

HWPopController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HWPopController', '~> 1.0.5'
```

## How to use

1. Create you popup UIViewController.
    1. import HWPopController framework
    2. config `contentSizeInPop` and `contentSizeInPopWhenLandscape`(if you want to support landscape)


    ```Objective-C
    #import "HWPop1ViewController.h"
    #import <HWPopController/HWPop.h>
    @interface HWPop1ViewController ()
    @end
    
    @implementation HWPop1ViewController
    
    - (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        self.contentSizeInPop = CGSizeMake(250, 300);
        self.contentSizeInPopWhenLandscape = CGSizeMake(300, 200);
        // build you pop view.
    }
    ```
1. Popup your viewController

    If you want high custom your popup, init HWPopController. Then config the properties what you want.
    Please see `HWPopController.h`
    
    ```Objective-C
    {
        HWPop1ViewController *pop1ViewController = [HWPop1ViewController new];
        HWPopController *popController = [[HWPopController alloc] initWithRootViewController:pop1ViewController];
        // popView position
        popController.popPosition = HWPopPositionTop;
        [popController presentInViewController:self];
    }
    ```
    
    Quick popup, use the UIViewController category.
    
    ```Objective-C
    HWPop1ViewController *pop1ViewController = [HWPop1ViewController new];
    [pop1ViewController popupWithPopType:HWPopTypeGrowIn dismissType:HWDismissTypeGrowOut dismissOnBackgroundTouch:YES];
    ```
    
1. Dismiss pop 
     Use native api.
     
    ```Objective-C
    [self dismissViewControllerAnimated:YES completion:^{
            
    }];
    ```
    
    Get popController, then call popController dismiss api.
    
    ```Objective-C
     [self.popController dismiss];
    ```

### Pop UINavigationController

If you want pop UINavigationController, and every stacked UIViewController contentSize is not same. You can use `HWPopNavigationController`.

`HWPopNavigationController` subclass `UINavigationController`, you can inherit from `HWPopNavigationController`, config contentSizeInPop as default contentSize.

When you push A Controller, then Push B Controller. A, B Controller should config contentSizeInPop if you need. If you have not config it, we will use NavigationController contentSizeInPop.

Relationship：
* UINavigationController
    * HWPopNavigationController 
        * Your custom UINavigationController inherit from HWPopNavigationController

**More details, pls see the Example.**

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

HeathWang, yishu.jay@gmail.com

## License

**HWPopController** is available under the MIT license. See the LICENSE file for more info.

# GTProgressBar

[![CI Status](http://img.shields.io/travis/gregttn/GTProgressBar.svg?style=flat)](https://travis-ci.org/gregttn/GTProgressBar)
[![Version](https://img.shields.io/cocoapods/v/GTProgressBar.svg?style=flat)](http://cocoapods.org/pods/GTProgressBar)
[![License](https://img.shields.io/cocoapods/l/GTProgressBar.svg?style=flat)](http://cocoapods.org/pods/GTProgressBar)
[![Platform](https://img.shields.io/cocoapods/p/GTProgressBar.svg?style=flat)](http://cocoapods.org/pods/GTProgressBar)

GTProgressBar is a customisable progress bar. You can adjust many visual settings of the progress bar to suit your use case. Customisation can be done in both the Interface Builder and in code. Here is a preview from the example app:

![Preview](https://raw.githubusercontent.com/gregttn/GTProgressBar/master/demo.gif)


## Example App

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

This component is written using Swift 3 so you will need to run Xcode 8 or higher.

# Usage

Many properties of GTProgressBar can be configured. Most of them can be configured in Interface Builder (@IBInspectable).

* @IBInspectable progress: CGFloat

  This property specifies how much of the bar is filled. The allowed values are from 0.0 to 1.0 . Default is 0.
  If progress label is displayed the value provided in here will be displayed as %
  The following example will cause 50% of the bar to be filled. The label will show 50%

  ```swift
  progressBar.progress = 0.5
  ```

* @IBInspectable barBorderColor: UIColor

  This property specifies the colour of the bar's border. Default is UIColor.black

  ```swift
  progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
  ```

* @IBInspectable barBackgroundColor: UIColor

  This property specifies the background colour of the progress bar within the control. Default is UIColor.white

  ```swift
  progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
  ```

* @IBInspectable barFillColor: UIColor

  This property specifies the fill colour of the progress bar. Default is UIColor.white

  ```swift
  progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
  ```

* @IBInspectable barBorderWidth: CGFloat

  This property specifies the width of the progress bar's border. Default is 2

  ```swift
  progressBar.barBorderWidth = 1
  ```

* @IBInspectable barFillInset: CGFloat

  This property specifies the inset between the fill of the bar and its border. Default is 2

  ```swift
  progressBar.barFillInset = 1
  ```

* @IBInspectable labelTextColor: UIColor

  This property specifies the fill colour of the label. Default is UIColor.black

  ```swift
  progressBar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
  ```

* @IBInspectable progressLabelInsets: UIEdgeInsets

  This property specifies the insets for the progress label. Default is UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

  Currently only the left and right inset is taken into account. The label itself will stay vertically centered within the view.

  ```swift
  progressBar.progressLabelInsets = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
  ```

* @IBInspectable cornerRadius: CGFloat

  This property specifies the radius of corners. Default is 0.0

  ```swift
  progressBar.cornerRadius = 10.0
  ```

* font: UIFont

  This property allows you to specify the font for the progress label. Default is UIFont.systemFont(ofSize: 12)

  ```swift
  progressBar.font = UIFont.boldSystemFont(ofSize: 18)
  ```

* barMaxHeight: CGFloat?

  This property allows you to specify the max height of the progress bar. By default the the progress bar will be sized to match the height of the whole view. If the max height is larger than the available view height it will be ignored.

  ```swift
  progressBar.barMaxHeight = 12
  ```
* animateTo(progress: CGFloat)

  This method animates the progress bar to the value specified. The allowed values are from 0.0 to 1.0 . If invalid value is provided it will be capped to the nearest allowed value.

  ```swift
  progressBar.animateTo(progress: 0.9)
  ```

To put it altogether here is a complete example configure GTProgressBar in code:

```swift
var progressBar = GTProgressBar(frame: CGRect(x: 0, y: 0, width: 300, height: 15))
progressBar.progress = 1
progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
progressBar.barBorderWidth = 1
progressBar.barFillInset = 2
progressBar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
progressBar.progressLabelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
progressBar.font = UIFont.boldSystemFont(ofSize: 18)
progressBar.barMaxHeight = 12

view.addSubview(progressBar)
```



## Installation

GTProgressBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GTProgressBar"
```



## Author

gregttn, gregttn@gmail.com

## License

GTProgressBar is available under the MIT license. See the LICENSE file for more info.

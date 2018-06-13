# GTProgressBar

[![CI Status](http://img.shields.io/travis/gregttn/GTProgressBar.svg?style=flat)](https://travis-ci.org/gregttn/GTProgressBar)
![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)
[![Version](https://img.shields.io/cocoapods/v/GTProgressBar.svg?style=flat)](http://cocoapods.org/pods/GTProgressBar)
[![License](https://img.shields.io/cocoapods/l/GTProgressBar.svg?style=flat)](http://cocoapods.org/pods/GTProgressBar)
[![Platform](https://img.shields.io/cocoapods/p/GTProgressBar.svg?style=flat)](http://cocoapods.org/pods/GTProgressBar)

GTProgressBar is a customisable progress bar. It supports both vertical and horizontal orientation, You can adjust many visual settings of the progress bar to suit your use case. Customisation can be done in both the Interface Builder and in code. Here is a preview from the example app:

![Preview](https://raw.githubusercontent.com/gregttn/GTProgressBar/master/demo.gif)


## Example App

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

This component is written using Swift 4 so you will need to run Xcode 9 or higher.

# Usage

Many properties of GTProgressBar can be configured. Most of them can be configured in Interface Builder (@IBInspectable).

* `orientation: GTProgressBarOrientation`
  This property allows you to specify the orientation of the bar: `horizontal` or `vertical`. By default it is set to horizontal

  ```swift
  progressBar.orientation = GTProgressBarOrientation.vertical
  ```

* `@IBInspectable orientationInt: Int`
  This property allows you to specify the orientation of the bar as Int. It defaults to horizontal. Current mapping is

  0 -> `GTProgressBarOrientation.horizontal`

  1 -> `GTProgressBarOrientation.vertical`

  ```swift
  progressBar.orientationInt = 1
  ```

* `direction: GTProgressBarDirection`
  This property allows you to specify the direction of the progress bar content: `clockwise` or `anticlockwise`. By default it is set to clockwise
  ```swift
  progressBar.direction = GTProgressBarDirection.anticlockwise
  ```

* `@IBInspectable directionInt: Int`
  This property allows you to specify the direction of the progress bar content as Int. It defaults to clockwise. Current mapping is

  0 -> `GTProgressBarDirection.clockwise`

  1 -> `GTProgressBarDirection.anticlockwise`

  ```swift
  progressBar.orientationInt = 1
  ```

* `@IBInspectable progress: CGFloat`

  This property specifies how much of the bar is filled. The allowed values are from 0.0 to 1.0 . Default is 0.
  If progress label is displayed the value provided in here will be displayed as %
  The following example will cause 50% of the bar to be filled. The label will show 50%

  ```swift
  progressBar.progress = 0.5
  ```

* `@IBInspectable displayLabel: Bool`

  This property specifies if the progress label should be displayed. Default is `true`.

  ```swift
  progressBar.displayLabel = false
  ```

* `@IBInspectable barBorderColor: UIColor`

  This property specifies the colour of the bar's border. Default is `UIColor.black`

  ```swift
  progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
  ```

* `@IBInspectable barBackgroundColor: UIColor`

  This property specifies the background colour of the progress bar within the control. Default is `UIColor.white`

  ```swift
  progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
  ```

* `@IBInspectable barFillColor: UIColor`

  This property specifies the fill colour of the progress bar. Default is UIColor.white

  ```swift
  progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
  ```

* `@IBInspectable barBorderWidth: CGFloat`

  This property specifies the width of the progress bar's border. Default is 2

  ```swift
  progressBar.barBorderWidth = 1
  ```

* `@IBInspectable barFillInset: CGFloat`

  This property specifies the inset between the fill of the bar and its border. Default is 2

  ```swift
  progressBar.barFillInset = 1
  ```

* `@IBInspectable labelTextColor: UIColor`

  This property specifies the fill colour of the label. Default is `UIColor.black`

  ```swift
  progressBar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
  ```

* `progressLabelInsets: UIEdgeInsets`

  This property specifies the insets for the progress label. Default is `UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)`

  ```swift
  progressBar.progressLabelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
  ```

* `@IBInspectable progressLabelInsetLeft: CGFloat`

  This property allows you to specify the left property of the progressLabelInsets in the Interface Builder. Default is 0.

  ```swift
  progressBar.progressLabelInsetLeft = 5.0
  ```

* `@IBInspectable progressLabelInsetRight: CGFloat`

  This property allows you to specify the right property of the progressLabelInsets in the Interface Builder. Default is 0.

  ```swift
  progressBar.progressLabelInsetRight = 5.0
  ```

* `@IBInspectable progressLabelInsetTop: CGFloat`

  This property allows you to specify the top property of the progressLabelInsets in the Interface Builder. Default is 0.

  ```swift
  progressBar.progressLabelInsetTop = 5.0
  ```

* `@IBInspectable progressLabelInsetBottom: CGFloat`

  This property allows you to specify the bottom property of the progressLabelInsets in the Interface Builder. Default is 0.

  ```swift
  progressBar.progressLabelInsetBottom = 5.0
  ```

* `@IBInspectable cornerRadius: CGFloat`

  This property specifies the radius of corners. Default is 0.0

  ```swift
  progressBar.cornerRadius = 10.0
  ```

* `font: UIFont`

  This property allows you to specify the font for the progress label. Default is `UIFont.systemFont(ofSize: 12)`

  ```swift
  progressBar.font = UIFont.boldSystemFont(ofSize: 18)
  ```

* `barMaxHeight: CGFloat?`

  This property allows you to specify the max height of the progress bar. By default the progress bar will be sized to match the height of the whole view. If the max height is larger than the available view height it will be ignored.

  ```swift
  progressBar.barMaxHeight = 12
  ```
* `@IBInspectable barMaxHeightInt: Int`

  This property allows you to specify the max height of the progress bar as an integer in the Interface Builder. By default the progress bar will be sized to match the height of the whole view. If the max height is larger than the available view height it will be ignored. If you set this property to 0 there will be no restriction on the height of the bar.

  ```swift
  progressBar.barMaxHeightInt = 12
  ```

* `barMaxWidth: CGFloat?`

  This property allows you to specify the max width of the progress bar. By default the progress bar will be sized to match the available free width. If the max width is larger than the available width it will be ignored.

  ```swift
  progressBar.barMaxWidth = 12
  ```

* `@IBInspectable barMaxWidthInt: Int`

  This property allows you to specify the max width of the progress bar as an integer in the Interface Builder. By default the progress bar will be sized to match the available free width. If the max width is larger than the available width it will be ignored. If you set this property to 0 there will be no restriction on the width of the bar.

  ```swift
  progressBar.barMaxWidthInt = 12
  ```

* `labelPosition: GTProgressBarLabelPosition`

  This property allows you to specify on which side the progress label should be placed. Default is `GTProgressBarLabelPosition.left`

  ```swift
  progressBar.labelPosition = GTProgressBarLabelPosition.right
  ```

* `@IBInspectable  labelPositionInt: Int`

  This property allows you to specify the position of the progress label using integers in the Interface Builder. Current mapping is

  0 -> `GTProgressBarLabelPosition.left`

  1 -> `GTProgressBarLabelPosition.right`

  2 -> `GTProgressBarLabelPosition.top`

  3 -> `GTProgressBarLabelPosition.bottom`

  ```swift
  progressBar.labelPosition = GTProgressBarLabelPosition.right
  ```

* `cornerType: GTProgressBarCornerType`

  This property allows you to specify the type of the corner (square or rounded). Default is `GTProgressBarCornerType.rounded`

  ```swift
  progressBar.cornerType = GTProgressBarCornerType.square
    ```

* `@IBInspectable  cornerTypeInt: Int`

  This property allows you to specify the type of the corner  using integers in the Interface Builder. Current mapping is

  0 -> `GTProgressBarCornerType.square`

  1 -> `GTProgressBarCornerType.rounded`

  ```swift
  progressBar.cornerTypeInt = GTProgressBarCornerType.rounded.rawValue
  ```

* `animateTo(progress: CGFloat, completion: (() -> Void)?)`

  This method animates the progress bar to the value specified. The allowed values are from 0.0 to 1.0 . If invalid value is provided it will be capped to the nearest allowed value. This method also accepts a completion callback executed when the animation completes.

  ```swift
  progressBar.animateTo(progress: 0.9) {
    print("Animation completed")
  }
  ```

To put it altogether here is an example configuration of GTProgressBar in code:

```swift
let progressBar = GTProgressBar(frame: CGRect(x: 0, y: 0, width: 300, height: 15))
progressBar.progress = 1
progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
progressBar.barBorderWidth = 1
progressBar.barFillInset = 2
progressBar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
progressBar.progressLabelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
progressBar.font = UIFont.boldSystemFont(ofSize: 18)
progressBar.labelPosition = GTProgressBarLabelPosition.right
progressBar.barMaxHeight = 12
progressBar.direction = GTProgressBarDirection.anticlockwise

view.addSubview(progressBar)
```



## Installation

### [Carthage](https://github.com/Carthage/Carthage)
To install it, simply add the following line to your Cartfile:

```
github "gregttn/GTProgressBar"
```

### [CocoaPods](http://cocoapods.org)
To install it, simply add the following line to your Podfile:

```ruby
pod "GTProgressBar"
```

## Author

gregttn, gregttn@gmail.com

## License

GTProgressBar is available under the MIT license. See the LICENSE file for more info.

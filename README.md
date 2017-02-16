# MDNotificationView

[![CI Status](http://img.shields.io/travis/moritzdietsche/mdnotificationview.svg?style=flat)](https://travis-ci.org/moritzdietsche/mdnotificationview)
[![codecov](https://codecov.io/gh/moritzdietsche/mdnotificationview/branch/master/graph/badge.svg)](https://codecov.io/gh/moritzdietsche/mdnotificationview)
[![Version](https://img.shields.io/cocoapods/v/MDNotificationView.svg?style=flat)](http://cocoapods.org/pods/MDNotificationView)
[![License](https://img.shields.io/cocoapods/l/MDNotificationView.svg?style=flat)](http://cocoapods.org/pods/MDNotificationView)
[![Platform](https://img.shields.io/cocoapods/p/MDNotificationView.svg?style=flat)](http://cocoapods.org/pods/MDNotificationView)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

MDNotificationView is…

## Screenshots

![alt tag](https://github.com/moritzdietsche/mdnotificationview/blob/master/Documentation/ExpandedImageLayoutView.png)
The `MDNotificationExpandedImageLayoutView` contains an image, a title and a text. Register your view controller as a `MDNotificationViewDelegate` to be notified if the user taps the view.

![alt tag](https://github.com/moritzdietsche/mdnotificationview/blob/master/Documentation/CompactLayoutView.png)
The `MDNotificationCompactLayoutView` contains a text of up to two lines. Like all layouts, its background and text properties can be customized.

![alt tag](https://github.com/moritzdietsche/mdnotificationview/blob/master/Documentation/CompactButtonLayoutView.png)
The `MDNotificationCompactButtonLayoutView` contains a button and a text. Add a gesture recognizer to the `UIButton` to trigger custom actions.

![alt tag](https://github.com/moritzdietsche/mdnotificationview/blob/master/Documentation/Custom%20UIView.png)
Pass a custom `UIView` to the `MDNotificationView` for more flexibility. Register your view controller as a `MDNotificationViewDelegate` to be notified when the view has been shown or hidden. E. g. hide the notification view after the download finishes.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 9.0+
* Swift 3.0+

## Installation

MDNotificationView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MDNotificationView"
```

## Questions & Issues

* Use [Stack Overflow](http://stackoverflow.com) if you have any questions. I watch the tag `mdnotificationview`.
* Open an issue if you found a bug or have a feature request.
* Submit a pull request if you want to contribute. Contributions are welcome!

## Author

Moritz Dietsche

## License

MDNotificationView is available under the MIT license. See the LICENSE file for more info.

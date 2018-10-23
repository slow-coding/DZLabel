# DZLabel

[![Version](https://img.shields.io/cocoapods/v/DZLabel.svg?style=flat)](https://cocoapods.org/pods/DZLabel)
[![License](https://img.shields.io/cocoapods/l/DZLabel.svg?style=flat)](https://cocoapods.org/pods/DZLabel)
[![Platform](https://img.shields.io/cocoapods/p/DZLabel.svg?style=flat)](https://cocoapods.org/pods/DZLabel)

![](QQ20180927-171545@2x.png)

## Introduction

- Base on UITextView.
- A replacement of UILabel, but more.
- Support for `Mentions`, `Links`, `Phone Numbers`, `Addresses`, `Emoticons(images)`
- Support custom `Regex` links
- Support setting link color
- Support detections of `Sinle-Tap on links`, `Single-Tap on Whole Text`, `Long-Press on links`
- Support automatic table view cell height calculation (autolayout)

## Usage

### 1. Basic Setup
``` swift
var label = DZLabel()
label.dzFont = UIFont.systemFont(ofSize: 14)
label.dzTextColor = UIColor.blue
label.dzLinkColor = UIColor.red
label.dzText = "test" // do not use .attributedText or .text
```

### 2. Enable Link Types
``` swift
label.dzEnabledTypes = [
    .address,
    .phone,
    .mention,
    .url,
    .emoticon(pattern: nil, // By default: "[EmoticonName]"
              bounds: CGRect(x: 0, y: -2, width: 10, height: 10), // Position and Size
              imageNameBlock: ({ name in // Text -> Local Image Name
                var imageName = name
                if imageName.hasPrefix("[") { imageName.removeFirst() }
                if imageName.hasSuffix("]") { imageName.removeLast() }
                return imageName})),
    .regex(pattern: "AM|PM"),
]
```

### 3. Handle Callbacks
``` swift
label.dzHandleMentionTap { result in
    print("mention tapped" + result)
}

label.dzHandleURLTap { result in
    print("url tapped" + result)
}

label.dzHandlePhoneTap { result in
    print("phone tapped" + result)
}

label.dzHandleAddressTap { result in
    print("address tapped" + result)
}

label.dzHandleKeywordLongPress {
    print("keyword long pressed")
}

label.dzHandleRegexKeywordTap { result in
    print("custom regex tapped" + result)
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 8+
- Swift 4

## Installation

DZLabel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DZLabel'
```

## Author

Darren Zheng, 623767307@qq.com

## License

DZLabel is available under the MIT license. See the LICENSE file for more info.

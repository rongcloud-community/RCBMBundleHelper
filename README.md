# RCBMBundleHelper

[![CI Status](https://img.shields.io/travis/gongjiahao/RCBMBundleHelper.svg?style=flat)](https://travis-ci.org/gongjiahao/RCBMBundleHelper)
[![Version](https://img.shields.io/cocoapods/v/RCBMBundleHelper.svg?style=flat)](https://cocoapods.org/pods/RCBMBundleHelper)
[![License](https://img.shields.io/cocoapods/l/RCBMBundleHelper.svg?style=flat)](https://cocoapods.org/pods/RCBMBundleHelper)
[![Platform](https://img.shields.io/cocoapods/p/RCBMBundleHelper.svg?style=flat)](https://cocoapods.org/pods/RCBMBundleHelper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RCBMBundleHelper is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RCBMBundleHelper'
```
## HowToUse
```Objective-C
/*
 * 获取静态pod的bundle路径.注意podName一般情况与bundle名一致,不一致,就传是在resource_bundles里面的名字
 * */
+ (NSBundle *)staticBundleWithPod:(NSString *)pod;

/*
 * 读取静态pod的bundle中的Localizable.strings文件的key
 * */
+ (NSString *)localizedString:(NSString *)key comment:(NSString *)comment inPod:(NSString *)pod;

/*
 * 读取静态pod的bundle中的[table].strings文件的key
 * */
+ (NSString *)localizedString:(NSString *)key comment:(NSString *)comment fromTable:(NSString *)table inPod:(NSString *)pod;

/*
 * 读取静态pod的bundle中的图片
 * */
+ (UIImage *)imageWithName:(NSString *)name fromPod:(NSString *)pod;

/*
 * 读取静态pod的bundle中的文件路径
 * */
+ (NSString *)fileUrlWithName:(NSString *)name ofType:(NSString *)type fromPod:(NSString *)pod;

#define RCBMBundleLocalizedNamed(keystr,commentstr,podstr) [RCBMBundleHelper localizedString:keystr comment:commentstr inPod:podstr]
#define RCBMBundleLocalizedTableNamed(keystr,commentstr,tablestr,podstr) [RCBMBundleHelper localizedString:keystr comment:commentstr fromTable:tablestr inPod:podstr]
```
## Author

arongshine, ashinecitic@gmail.com

## Carthage support
* create framwork project
`carthage build --no-skip-current --use-xcframeworks`

## License

RCBMBundleHelper is available under the MIT license. See the LICENSE file for more info.

//
//  RCBMBundleHelper.h
//  RCBMBundleHelper
//
//  Created by dev on 2022/9/9.
//

#import <Foundation/Foundation.h>
@import UIKit;
NS_ASSUME_NONNULL_BEGIN

@interface RCBMBundleHelper : NSObject
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

@end

@interface UIImage (RCBMPodBundle)
+ (UIImage *)imageNamed:(NSString *)name formRCBMPod:(NSString *)pod;

@end

NS_ASSUME_NONNULL_END

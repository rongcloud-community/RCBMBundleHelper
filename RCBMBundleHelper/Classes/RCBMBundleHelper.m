//
//  RCBMBundleHelper.m
//  RCBMBundleHelper
//
//  Created by dev on 2022/9/9.
//

#import "RCBMBundleHelper.h"

@implementation RCBMBundleHelper

/**
 获取文件所在name，默认情况下podName和bundlename相同，传一个即可
 @param bundleName bundle名字，就是在resource_bundles里面的名字
 @param podName pod的名字
 @return bundle
 */
+ (NSBundle *)bundleWithBundleName:(NSString *)bundleName podName:(NSString *)podName{
    if (bundleName == nil && podName == nil) {
        @throw @"bundleName和podName不能同时为空";
    }else if (bundleName == nil ) {
        bundleName = podName;
    }else if (podName == nil) {
        podName = bundleName;
    }
    
    if ([bundleName containsString:@".bundle"]) {
        bundleName = [bundleName componentsSeparatedByString:@".bundle"].firstObject;
    }
    //没使用framwork的情况下
    NSURL *associateBundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    //使用framework形式
    if (!associateBundleURL) {
        associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
        associateBundleURL = [associateBundleURL URLByAppendingPathComponent:podName];
        associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
        NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
        associateBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
    }
    
    NSAssert(associateBundleURL, @"取不到关联bundle,请核查podspec中的resource_bundles配置");
    //生产环境直接返回空
    return associateBundleURL?[NSBundle bundleWithURL:associateBundleURL]:nil;
}



/// 获取静态pod的bundle路径.
/// @param pod  就是在resource_bundles里面的名字,默认同pod 名称
+ (NSBundle *)staticBundleWithPod:(NSString *)pod
{
    /*
 // TODO: 对于之中种不使用framewok的情况资源调用很简单，只需要一个bundlename参数,即podfile中不使用use_frameworks!
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *url = [bundle URLForResource:pod withExtension:@"bundle"];
    NSBundle * podBundle = [NSBundle bundleWithURL:url];
    return url ? podBundle : nil;
    */
    return [self bundleWithBundleName:pod podName:pod];
}

+ (NSString *)localizedString:(NSString *)key comment:(NSString *)comment inPod:(NSString *)pod
{
    return NSLocalizedStringFromTableInBundle(key, nil, [self staticBundleWithPod:pod], comment);
}

+ (NSString *)localizedString:(NSString *)key comment:(NSString *)comment fromTable:(NSString *)table inPod:(NSString *)pod
{
    return NSLocalizedStringFromTableInBundle(key, table, [self staticBundleWithPod:pod], comment);
}

+ (UIImage *)imageWithName:(NSString *)name fromPod:(NSString *)pod
{
//TODO: 这里能向下兼容iOS8,增加程序的健壮性
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    return [UIImage imageNamed:name inBundle:[self staticBundleWithPod:pod] compatibleWithTraitCollection:nil];
#elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    return [self imageWithContentsOfFile:[[self staticBundleWithPod:pod] pathForResource:[self scaleName:name] ofType:@"png"]];
#else
    if ([self respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
           return [self imageNamed:name inBundle:[self staticBundleWithPod:pod] compatibleWithTraitCollection:nil];
       } else {
           return [self imageWithContentsOfFile:[[self staticBundleWithPod:pod] pathForResource:[self scaleName:name] ofType:@"png"]];
       }
#endif
}

+ (NSString *)fileUrlWithName:(NSString *)name ofType:(NSString *)type fromPod:(NSString *)pod
{
    NSBundle *bundle = [self staticBundleWithPod:pod];
    return [bundle pathForResource:name ofType:type];
}

+(NSString *)scaleName:(NSString *)imageName{
    NSInteger scale = [[UIScreen mainScreen] scale];
    NSString *scaleName = [NSString stringWithFormat:@"%@@%zdx",imageName,scale];
    return scaleName;
}




@end

@implementation UIImage (RCBMPodBundle)
+ (UIImage *)imageNamed:(NSString *)name formRCBMPod:(NSString *)pod
{
    return [RCBMBundleHelper imageWithName:name fromPod:pod];
}
/*
+ (instancetype)rcbm_imagePathWithName:(NSString *)imageName
                                bundle:(NSString *)bundle
                           targetClass:(Class)targetClass{
    NSString * bundlePath = [[NSBundle bundleForClass:targetClass].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.bundle",bundle]];
    NSBundle *currentBundle = [NSBundle bundleWithPath:bundlePath];
    UIImage *image = [UIImage imageNamed:imageName inBundle:currentBundle compatibleWithTraitCollection:nil];
    NSAssert(image, @"%@.Bundle：name 为 %@ 的图片找不到",bundle, imageName);
    // NSAssert(image, @"YGBundle：name 为 %@ 的图片找不到", imageName);
    return bundlePath ? image : nil;
}
*/
@end

echo "build begin"

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

CURRENTDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $CURRENTDIR

XCPROJ="${CURRENTDIR}/RCBMBundleHelper.xcodeproj"
SCHEME="RCBMBundleHelper"

EXPORT="${CURRENTDIR}/FrameworkPod/build"
SIMULATOREXPORT="${EXPORT}/${SCHEME}-iphonesimulator.xcarchive"
SIMULATOARMREXPORT="${EXPORT}/${SCHEME}-iphonesimulator-arm64.xcarchive"
PHONEEXPORT="${EXPORT}/${SCHEME}-iphoneos.xcarchive"
FRAMEWORKPODDIR=$"${CURRENTDIR}/FrameworkPod"

echo "current dir is " ${CURRENTDIR}
echo ${EXPORT}

if [ -d $EXPORT ]; then
    rm -rf $EXPORT
    mkdir -p  $EXPORT
else
    mkdir -p  $EXPORT
fi

echo "EXPORT -> $EXPORT"




#echo "start iOS Simulator arm64 ..." # 因openssl.framework 无arm64架构,故而跳过
## Simulator arm64
#xcodebuild archive\
#   -workspace ${WORKSPACE} \
#   -scheme ${SCHEME} \
#   -archivePath $SIMULATOARMREXPORT \
#   -sdk iphonesimulator \
#   -arch arm64 \
#   -UseModernBuildSystem=NO \
#   -allowProvisioningUpdates\
#   SKIP_INSTALL=NO \
#   | $(which xcpretty)
#   # BUILD_LIBRARY_FOR_DISTRIBUTION=YES \

echo "start Simulator X86_64 ..."
# Simulator X86_64
xcodebuild archive\
    -project ${XCPROJ} \
    -scheme ${SCHEME} \
    -archivePath $SIMULATOREXPORT \
    -sdk iphonesimulator \
    -arch x86_64 \
    -UseModernBuildSystem=YES \
    -allowProvisioningUpdates \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    | $(which xcpretty)
#   -destination "generic/platform=iOS Simulator" \




echo "start platform=iOS ..."

# iphones
xcodebuild archive\
    -project ${XCPROJ} \
    -scheme ${SCHEME} \
    -sdk iphoneos \
    -archivePath  $PHONEEXPORT\
    -UseModernBuildSystem=YES\
    -allowProvisioningUpdates\
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    | $(which xcpretty)
    
#-destination "generic/platform=iOS" \
# # Create xcframwork combine of all frameworks
xcodebuild \
    -create-xcframework \
    -framework "${SIMULATOREXPORT}/Products/Library/Frameworks/${SCHEME}.framework" \
    -framework "${PHONEEXPORT}/Products/Library/Frameworks/${SCHEME}.framework" \
    -output "${EXPORT}/${SCHEME}.xcframework"
    
if [ -d "$FRAMEWORKPODDIR/${SCHEME}.xcframework" ]; then
    rm -rf $FRAMEWORKPODDIR/${SCHEME}.xcframework
fi

# 这样是存在问题的的,经过测试,zip 是全路径,会引发错误
#/usr/bin/zip -r ${EXPORT}/${SCHEME}.xcframework.zip ${EXPORT}/${SCHEME}.xcframework 
cd  ${EXPORT}
/usr/bin/zip -r ${SCHEME}.xcframework.zip ${SCHEME}.xcframework


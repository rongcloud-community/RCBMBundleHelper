#
# Be sure to run `pod lib lint RCBMBundleHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RCBMBundleHelper'
  s.version          = '1.0.1'
  s.summary          = 'RCBMBundleHelper.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
RCBM Pod资源文件Bundle统一读取
                       DESC

  s.homepage         = 'https://github.com/rongcloud-community/RCBMBundleHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'asunrong' => 'ashinecitic@gmail.com' }
# s.source           = { :git => 'https://github.com/rongcloud-community/RCBMBundleHelper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  # 根据静态资源服务替换填写<your path>/
  yg_zipURl="https://aswift.tk/RCBMBundleHelper/v#{s.version.to_s}/RCBMBundleHelper.xcframework.zip"
  s.ios.deployment_target = '9.0'
  
  if ENV['IS_SOURCE'] || ENV["#{s.name}_IS_SOURCE"]
          # 如果是源码，则使用git地址
    s.source           = { :git => 'https://github.com/rongcloud-community/RCBMBundleHelper.git', :tag => s.version.to_s }
  else
          # 如果是二进制，则是用zip地址
    s.source           = { :http => yg_zipURl}
  end
  
  if ENV['IS_SOURCE'] || ENV['${POD_NAME}_IS_SOURCE']
  
    # if !ENV['${POD_NAME}_IS_SOURCE'] # 若之前加!则默认为源码的处理
    # 若之前加!则默认为源码的处理
    # 因为源码使用的是git，所以执行downlolad_zip去把zip下载下来
    # prepare_command这一段是pod install时会执行的脚本 ${POD_NAME} ${KVersion}
    # test -f download_zip.sh &&
#   s.prepare_command =  <<-CMD
#     sh Scripts/download_zip.sh ${POD_NAME}
#     CMD
  
    puts '-------------------------------------------------------------------'
    puts "Notice:#{s.name} is source now"
    puts '-------------------------------------------------------------------'
    s.source_files = 'RCBMBundleHelper/Classes/**/*'
    s.public_header_files = 'RCBMBundleHelper/Classes/**/*.h'
  else
    puts '-------------------------------------------------------------------'
    puts "#{s.name}: FW here binary now " 
    puts '-------------------------------------------------------------------'
    s.ios.vendored_frameworks = 'RCBMBundleHelper.xcframework'
  end
  
  
#   s.resource_bundles = {
#     'RCBMBundleHelper' => ['RCBMBundleHelper/Assets/*']
#   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

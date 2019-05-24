#
# Be sure to run `pod lib lint HWPopController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HWPopController'
  s.version          = '1.0.2'
  s.summary          = 'HWPopController pop up in ViewController with some animations.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        Use ViewController to present HWPopController like pop up style.
                        Support multiple Animations.
                       DESC

  s.homepage         = 'https://github.com/HeathWang/HWPopController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HeathWang' => 'yishu.jay@gmail.com' }
  s.source           = { :git => 'https://github.com/HeathWang/HWPopController.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '8.0'

  s.source_files = 'HWPopController/Classes/**/*'
  s.public_header_files = 'HWPopController/Classes/**/*.h'
  s.frameworks = 'UIKit'
  
  # s.resource_bundles = {
  #   'HWPopController' => ['HWPopController/Assets/*.png']
  # }

  # s.dependency 'AFNetworking', '~> 2.3'
end

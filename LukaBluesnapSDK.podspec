Pod::Spec.new do |s|
  s.name         = 'LukaBluesnapSDK'
  s.version      = '1.0.7'
  s.summary      = 'A module for integrating the LukaBluesnapSDK into your iOS project.'
  s.description  = 'This module provides functionality for working with the LukaBluesnapSDK in your iOS app.'
  s.homepage     = 'https://github.com/josem0796/LukaBluesnapSDK'
#  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Jose Moran' => 'jmoran@lukapay.io' }
  s.source       = { :git => 'https://github.com/josem0796/LukaBluesnapSDK.git', :tag => s.version.to_s }

  s.platform     = :ios, '15.0'
  s.source_files = 'LukaBluesnap/**/*.{h,m,swift}'
  s.resources    = 'LukaBluesnap/**/*.{ttf,strings,xcassets}'
  s.frameworks   = 'UIKit', 'Foundation'
  s.dependency 'BluesnapSDK'
  s.dependency 'Alamofire'
  # Specify any other configurations, such as subspecs, test specs, and custom build settings.
end

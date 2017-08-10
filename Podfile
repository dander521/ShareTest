
target ‘Uhome’ do
  platform :ios, ‘9.0’
  use_frameworks!
  pod 'SDWebImage'
  pod 'Alamofire'
  pod 'Masonry'
  pod 'MJExtension'
  pod 'IQKeyboardManagerSwift'
  pod 'ObjectMapper'
  pod 'Validator'
  pod 'KRProgressHUD'
  pod 'Then'
  pod 'SwiftDate'
  pod 'Kingfisher'
  pod 'HandyJSON'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
            config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
        end
    end
end


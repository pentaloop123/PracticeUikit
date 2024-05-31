source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def tor
  pod 'Tor/GeoIP',
  :podspec => 'https://raw.githubusercontent.com/iCepa/Tor.framework/pure_pod/TorStatic.podspec'
end

def iptproxy
  pod 'IPtProxyUI/AppEx',
  '~> 4.2'
end

target 'PracticeUIkit' do
  platform :ios, '15.0'
  
  #  tor
  #  iptproxy
  
  pod 'Eureka', '~> 5.3'
  pod 'ProgressHUD', '~> 13.6'
  pod 'lottie-ios', '~> 4.0'
  pod 'IQKeyboardManagerSwift'
  pod 'SwiftyStoreKit'
  pod 'CouchbaseLite-Swift'

  
  pod 'AWSS3' 
#  pod 'AWSCognito', '~> 2.6.13'
  
  
end


target 'TorVPN' do
  
  platform :ios, '15.0'
  
  #  tor
  #  iptproxy
  pod 'GCDWebServerExtension', :git => 'https://github.com/tladesignz/GCDWebServer.git'
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.respond_to?(:name) and !target.name.start_with?("Pods-")
      target.build_configurations.each do |config|
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
      end
    end
  end
end


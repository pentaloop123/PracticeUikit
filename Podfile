source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def tor
  pod 'Tor/GeoIP-NoLZMA',
   '~> 408.10'
end


target 'PracticeUIkit' do
  use_frameworks!
  pod 'NEOnionProxyLibrary'
#  tor
 
end

target 'TorVPN' do
  use_frameworks!
  
#  tor

    
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

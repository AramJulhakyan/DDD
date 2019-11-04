# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
workspace 'DDDModularArchitecture'

inhibit_all_warnings!
use_frameworks!

# Disable Code Coverage for Pods projects

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
        end
    end
end

# Variables

$extension  = '.xcodeproj'

$libraries  = 'Libraries'

$core       = $libraries + '/Core'

$modules    = $libraries + '/Modules'

$kits       = $libraries + '/Kits'

# Pods Group

def rx
  pod 'RxSwift',    '~> 5.0.0'
  pod 'RxCocoa',    '~> 5.0.0'
end

def rxTests
  pod 'RxBlocking', '~> 5.0.0'
  pod 'RxTest',     '~> 5.0.0'
end

def snapKit
  pod 'SnapKit',    '~> 5.0.0'
end

def swiftLint
  pod 'SwiftLint',  '~> 0.34.0'
end

def kingfisher
  pod 'Kingfisher', '~> 5.0'
end

# Targets

abstract_target 'app' do

  target 'DDDModularArchitecture' do
    project 'DDDModularArchitecture' + $extension
    
    rx
    snapKit
    swiftLint
    kingfisher
  end

end

abstract_target 'core' do
  swiftLint
  
  target 'MyFoundation' do
    project $core + '/MyFoundation/MyFoundation' + $extension
  end
  
  target 'System' do
    project $core + '/System/System' + $extension
  end
end

abstract_target 'kits' do
  swiftLint
  
  target 'MyUIKit' do
    project $kits + '/MyUIKit/MyUIKit' + $extension
    kingfisher
    snapKit
  end

end


abstract_target 'modules' do
  rx
  snapKit
  swiftLint
  
  target 'Authentication' do
    project $modules + '/Authentication/Authentication' + $extension
  end
  
  target 'Feed' do
    project $modules + '/Feed/Feed' + $extension
  end
  
  target 'Guests' do
    project $modules + '/Guests/Guests' + $extension
  end

end

abstract_target 'tests-modules' do
  rxTests
  kingfisher
  
  target 'AuthenticationTests' do
    project $modules + '/Authentication/Authentication' + $extension
  end
  
  target 'FeedTests' do
    project $modules + '/Feed/Feed' + $extension
  end
end

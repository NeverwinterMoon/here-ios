# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'AppEntity' do
  use_frameworks!

  target 'AppEntityTests' do
    inherit! :search_paths
  end
end

target 'AppExtensions' do
  use_frameworks!
  pod 'Firebase'
end

target 'AppInteractor' do
  use_frameworks!

  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Storage'
end

target 'AppRequest' do
  use_frameworks!
end

target 'AppScreen' do
  use_frameworks!

  pod 'Firebase'
  target 'AppScreenTests' do
    inherit! :search_paths
  end
end

target 'AppUIKit' do
  use_frameworks!
end

target 'NowHere' do
  use_frameworks!

  target 'NowHereTests' do
    inherit! :search_paths
  end

  target 'NowHereUITests' do
    inherit! :search_paths
  end

  pod 'Firebase/Core'
  pod 'Firebase/Storage'
end

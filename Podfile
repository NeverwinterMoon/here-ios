# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

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

  pod 'Firebase'
  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
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
    pod 'Firebase'
  end
end

target 'AppUIKit' do
  use_frameworks!
end

target 'NowHere' do
  use_frameworks!
  pod 'Firebase'
  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'Firebase/Storage'

  target 'NowHereTests' do
    inherit! :search_paths
    pod 'Firebase'
  end

  target 'NowHereUITests' do
    inherit! :search_paths
  end
end

Pod::Spec.new do |s|
  s.name         = "STManagedTracker"
  s.version      = "0.0.1"
  s.summary      = "Sys-team STManagedTracker."

  s.homepage     = "http://EXAMPLE/STManagedTracker"

  s.license      = 'MIT'

  s.author       = { "Grigoriev Maxim" => "grigoriev.maxim@gmail.com" }

  s.source       = { :git => "http://EXAMPLE/STManagedTracker.git", :tag => "0.0.1" }

  s.platform     = :ios, '5.0'


  s.source_files = 'Classes', 'Classes/**/*.{h,m}'

  s.frameworks = 'SystemConfiguration', 'CoreData', 'CoreLocation', 'UIKit', 'Foundation', 'CoreGraphics'

  s.dependency 'UDPushAuth', :git => 'https://github.com/Unact/UDPushAuth.git', :branch => 'master'

end

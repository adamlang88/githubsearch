platform :ios, '13.0'
inhibit_all_warnings!
use_frameworks!

target 'GitHubSearch' do
 
  pod 'Alamofire', '5.4.0'
  pod 'Swinject', '2.7.1'
  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
  pod 'RxBlocking', '6.2.0'
  pod 'SDWebImage', '5.11.1'

  target 'GitHubSearchTests' do
    inherit! :complete     
  end

  target 'GitHubSearchUITests' do
    inherit! :complete
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    
  end
end

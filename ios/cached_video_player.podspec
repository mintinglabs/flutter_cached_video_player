#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'cached_video_player'
  s.version          = '0.0.2'
  s.summary          = 'Cached Video Player'
  s.description      = <<-DESC
Cached Video Player
                       DESC
  s.homepage         = 'https://github.com/vikram25897/flutter_cached_video_player'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'Vikram Pratap Singh' => 'vikram@lazyarts.me' }
  s.source           = { :http => 'https://github.com/vikram25897/flutter_cached_video_player' }
  s.documentation_url = 'https://pub.dev/packages/cached_video_player'
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  # KTVHTTPCache
  s.dependency 'KTVHTTPCache', '~> 3.0.2'

  s.platform = :ios, '11.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end


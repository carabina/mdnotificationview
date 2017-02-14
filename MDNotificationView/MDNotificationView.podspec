#
# Be sure to run `pod lib lint MDNotificationView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MDNotificationView'
  s.version          = '0.1.0'
  s.summary          = 'Notification views for iOS apps.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
MDNotificationView provides customizable views that slide in from the top or the bottom. They may contain a predefined view layout or custom views.
                       DESC

  s.homepage         = 'https://github.com/moritzdietsche/mdnotificationview'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Moritz Dietsche' }
  s.source           = { :git => 'https://github.com/moritzdietsche/mdnotificationview.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'MDNotificationView/Sources/**/*'
  
  s.resource_bundles = {
    'MDNotificationView' => ['MDNotificationView/Assets/*']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

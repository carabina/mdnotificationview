#
# Be sure to run `pod lib lint MDNotificationView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MDNotificationView'
  s.version          = '1.0.0'
  s.summary          = 'Notification views for iOS apps.'

  s.description      = <<-DESC
MDNotificationView provides a customizable view that slide in from the top or the bottom. Use MDNotificationViews for in-app notifications (e. g. in a chat app) or to provide feedback to your app's users (e. g. "Settings changes" and an undo button next to it). MDNotificationViews behave mostly like Material Design Snackbars but are fully customizable. This means you can select from a few predefined layouts or implement your own UIView. The MDNotificationView propagates livecycle and tap events to its delegate, telling your app when it has been shown, hidden or tapped. And of course, it will adjust to the status bar size and to rotation.
                       DESC

  s.homepage         = 'https://github.com/moritzdietsche/mdnotificationview'
  s.screenshots      = 'https://github.com/moritzdietsche/mdnotificationview/blob/master/Documentation/ExpandedImageLayoutView.png?raw=true', 'https://github.com/moritzdietsche/mdnotificationview/blob/master/Documentation/CompactLayoutView.png?raw=true', 'https://github.com/moritzdietsche/mdnotificationview/blob/master/Documentation/CompactButtonLayoutView.png?raw=true', 'https://github.com/moritzdietsche/mdnotificationview/blob/master/Documentation/Custom%20UIView.png?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Moritz Dietsche'
  s.source           = { :git => 'https://github.com/moritzdietsche/mdnotificationview.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'MDNotificationView/Sources/**/*'
  
  s.resource_bundles = {
    'MDNotificationView' => ['MDNotificationView/Assets/*']
  }

  s.frameworks = 'UIKit'
end

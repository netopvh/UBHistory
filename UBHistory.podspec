#
# Be sure to run `pod lib lint UBHistory.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UBHistory'
  s.version          = '1.1.9'
  s.summary          = 'A short description of UBHistory.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://git.usemobile.com.br/libs-iOS/use-blue/history'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tulio de Oliveira Parreiras' => 'tulio@usemobile.xyz' }
  s.source           = { :git => 'http://git.usemobile.com.br/libs-iOS/use-blue/history.git', :tag => s.version.to_s }

  s.swift_version    = '4.2'
  s.ios.deployment_target = '10.1'

  s.source_files = 'UBHistory/Classes/**/*'
  
   s.resource_bundles = {
     'UBHistory' => ['UBHistory/Assets/*']
   }

  s.static_framework = true
  s.dependency 'USE_Coordinator'
  s.dependency 'HCSStarRatingView'
  s.dependency 'UIScrollView-InfiniteScroll'
  s.dependency 'lottie-ios', '~> 2.5.2'
  s.frameworks = 'UIKit'
  
end

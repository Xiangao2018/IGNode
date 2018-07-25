#
# Be sure to run `pod lib lint Identifiable.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Identifiable'
  s.version          = '0.9.1'
  s.summary          = 'Identifier-based framework'
  s.description      = <<-DESC	
	If a type is identifier-based, then it has a lot of features for free, exp Equatable, Hashable, Comparable. Based on Identifier concept, lots of algorithm can be reused.   
                       DESC

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage         = 'https://bitbucket.org/LittleRock/identifiable'
  s.author           = { 'Rocke' => 'LittleRockInRed@gmail.com' }
  s.source           = { :path => '.' }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Identifiable/*.swift'
  
end

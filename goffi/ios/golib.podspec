#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint golibsimulator.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'golibsimulator'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://aquarian-age.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@amrta.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'
  # TODO(dacoharkes): exclude i386 again, and enable simulator on Mac M1.
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
   # 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64'
  }
  s.vendored_libraries = 'Frameworks/golibsimulator.dylib', 'Frameworks/golibsimulator.dylib'
  s.swift_version = '5.0'
end

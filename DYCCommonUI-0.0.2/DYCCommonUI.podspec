Pod::Spec.new do |s|
  s.name = 'DYCCommonUI'
  s.version = '0.0.2'
  s.summary = 'public UI'
  s.license = 'LICENSE'
  s.authors = {"TyrantDante"=>"804054226@qq.com"}
  s.homepage = 'https://github.com/TyrantDante/DYCCommonUI'
  s.description = 'public UI that all project can use'
  s.source = {}

  s.platform = :ios, '7.0'
  s.ios.platform             = :ios, '7.0'
  s.ios.preserve_paths       = 'ios/DYCCommonUI.framework'
  s.ios.public_header_files  = 'ios/DYCCommonUI.framework/Versions/A/Headers/*.h'
  s.ios.resource             = 'ios/DYCCommonUI.framework/Versions/A/Resources/**/*'
  s.ios.vendored_frameworks  = 'ios/DYCCommonUI.framework'
end

Pod::Spec.new do |s|
  s.name             = 'FHMultilineTextField'
  s.version          = '0.1.0'
  s.summary          = 'Multiline textfield is written in Swift 3 with a customizable line.'

  s.description      = <<-DESC
                      Multiline textfield is written in Swift 3 with a customizable line. Author is Furkan Hatipoglu.
                       DESC

  s.homepage         = 'https://github.com/furkanhatipoglu/multiline-textfield.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Furkan Hatipoglu' => 'frknhatipoglu@gmail.com' }
  s.source           = { :git => 'https://github.com/furkanhatipoglu/multiline-textfield.git', :tag => s.version.to_s }

  s.dependency 'GrowingTextView', '~> 0.4.0'

  s.ios.deployment_target = '8.0'
  s.resources             = 'MultiLineTextField/*'
  s.source_files          = 'MultiLineTextField/*'

end

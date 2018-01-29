Pod::Spec.new do |s|
  s.name             = 'Multiline-TextField'
  s.version          = '0.0.5'
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
  s.resources             = 'MultilineTextField/*'
  s.source_files          = 'MultilineTextField/*'

end

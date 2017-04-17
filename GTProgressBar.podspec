Pod::Spec.new do |s|
  s.name             = 'GTProgressBar'
  s.version          = '0.1.2'
  s.summary          = 'GTProgressBar is a customisable progress bar written in Swift 3'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
GTProgressBar is a customisable progress bar written in Swift 3.
                       DESC

  s.homepage         = 'https://github.com/gregttn/GTProgressBar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gregttn' => 'gregttn@gmail.com' }
  s.source           = { :git => 'https://github.com/gregttn/GTProgressBar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/gregttn'

  s.ios.deployment_target = '8.3'

  s.source_files = 'GTProgressBar/Classes/**/*'
  
end

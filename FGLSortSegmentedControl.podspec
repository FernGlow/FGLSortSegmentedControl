Pod::Spec.new do |s|
  s.name         = "FGLSortSegmentedControl"
  s.version      = "0.2.0"
  s.summary      = "FGLSortSegmentedControl is a UISegmentedControl subclass that appends an ascending or descending string to the selected segment's title."
  s.homepage     = "http://github.com/FernGlow/FGLSortSegmentedControl"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Andrew Michaelson" => "andrew@fernglow.com" }
  s.source       = { :git => "http://github.com/FernGlow/FGLSortSegmentedControl", :tag => "0.1.0" }
  s.platform     = :ios, '5.0'
  s.source_files = 'FGLSortSegmentedControl/**/*.{h,m}'
  s.preserve_paths = ['FGLSortSegmentedControl', 'README.md', 'LICENSE']
  s.requires_arc = true
end

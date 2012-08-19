Pod::Spec.new do |s|
  s.name         = "FGSortSegmentedControl"
  s.version      = "0.1.0"
  s.summary      = "FGSortSegmentedControl is a UISegmentedControl subclass that appends an ascending or descending string to the selected segment's title."
  s.homepage     = "http://github.com/FernGlow/FGSortSegmentedControl"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Andrew Michaelson" => "andrew@fernglow.com" }
  s.source       = { :git => "http://github.com/FernGlow/FGSortSegmentedControl.git", :tag => "0.1.0" }
  s.platform     = :ios, '5.0'
  s.source_files = 'FGSortSegmentedControl'
  s.preserve_paths = ['FGSortSegmentedControl', 'README.md', 'LICENSE']
  s.requires_arc = true
end


Pod::Spec.new do |s|

  s.name         = "ReactiveZ"
  s.version      = "0.0.6"
  s.summary      = "This is a beginning of lightweight reactive programming."
  s.description  = "Lightweight Reactive programming library in swift. With this libray you can bind control with observable field to make it reactive."
  s.homepage     = "https://github.com/MenhSowattana/ReactiveZ"
  s.license      = "MIT"
  s.author             = { "Sowattana" => "sowattana.menh@r-up.jp" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/MenhSowattana/ReactiveZ.git", :tag => "0.0.6" }
  s.source_files = "ReactiveZ/**/*.swift"

end

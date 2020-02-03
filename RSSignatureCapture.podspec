require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "RSSignatureCapture"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.author       = 'codelab'
  s.homepage     = package["_from"]
  s.license      = package["license"]
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Codelabsys/react-native-signature-capture.git", :tag => "v#{s.version}" }
  s.source_files  = "ios/*.{h,m}"
  s.dependency "React"
end
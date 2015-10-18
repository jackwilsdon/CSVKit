Pod::Spec.new do |s|
  s.name         = "CSVKit"
  s.version      = "0.3.3"
  s.summary      = "A simple CSV parser written in Swift."

  s.description  = <<-DESC
                    A simple CSV parser written in Swift.

                    Features a nice safety system to make it easy to use without
                    messing around with optionals, even if a field does not exist!
                   DESC

  s.homepage     = "https://github.com/jackwilsdon/CSVKit"
  s.license      = { :type => "LGPL" }
  s.author             = { "Jack Wilsdon" => "jack.wilsdon@gmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/jackwilsdon/CSVKit.git", :tag => "0.3.3" }
  s.source_files  = "CSVKit", "CSVKit/**/*.{h,swift}"
end

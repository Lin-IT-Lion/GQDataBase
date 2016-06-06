

Pod::Spec.new do |s|
  s.name             = "GQDataBase"
  s.version          = "0.0.1"
  s.summary          = "GQDataBase For Lin_IT"
  s.description      = "Data persistent storage layer"
  s.author           = { "GuoQiang Lin" => "lin_it@outlook.com" }
  s.source           = { :git => "https://github.com/Lin-IT-Lion/GQDataBase.git", :tag => "0.0.1" }
  s.homepage         = "http://www.linit.space"
  s.source_files     = 'GQDataBase/**/*.{h,m}'
  #s.resources = ''

  s.ios.dependency 'Realm+JSON'
  s.ios.dependency 'Realm', '0.98.6'
  s.ios.dependency 'MJExtension'
  #s.ios.dependency 'FMDB'
  s.platform     = :ios, "7.0"
  s.license          = "Copyright (c) 2016年 lgq. All rights reserved."

  #s.license      = "MIT (example)"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

end

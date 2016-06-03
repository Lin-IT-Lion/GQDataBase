
Pod::Spec.new do |s|
  s.name             = "GQDataBase"
  s.version          = "1.0.0"
  s.summary          = "GQDataBase For Lin_IT"
  s.description      = "Data persistent storage layer"
  s.license          = "lgq"
  s.author           = { "GuoQiang Lin" => "lin_it@outlook.com" }
  s.source           = { :git => "https://github.com/Lin-IT-Lion/GQDataBase.git", :tag => "0.0.1" }
  s.homepage 	 	     = "http://www.linit.space"
  s.source_files     = 'GQDataBase/**/*.{h,m}'
  #s.resources = ''

  s.ios.dependency 'Realm+JSON'
  s.ios.dependency 'Realm'
  s.ios.dependency 'MJExtension'
  s.ios.dependency 'FMDB'
  s.platform     = :ios, "7.0"
end
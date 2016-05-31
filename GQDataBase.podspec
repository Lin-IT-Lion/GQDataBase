
Pod::Spec.new do |s|
  s.name             = "GQDataBase"
  s.version          = "1.0.0"
  s.summary          = "formtable For Lin_IT"
  s.description      = "Quickly generate forms and provide verification"
  s.license          = "lgq"
  s.author           = { "GuoQiang Lin" => "lin_it@outlook.com" }
  s.source           = { :git => "https://github.com/Lin-IT-Lion/GQDataBase.git" , :tag => "0.0.1" } 
  s.homepage 	 	 = "https://github.com/Lin-IT-Lion"
  s.source_files     = 'GQDataBase/**/*.{h,m}'
  #s.resources = ''

  s.ios.dependency 'Realm+JSON'
  s.ios.dependency 'Realm'
  s.ios.dependency 'MJExtension'
  s.ios.dependency 'FMDB'

end
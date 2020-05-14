

Pod::Spec.new do |s|
  s.name             = 'mPaas'
  s.version          = '0.0.3'
  s.summary          = 'Modular support framework'
  s.description      = <<-DESC
                    Modular support framework just like BeeHive.
                       DESC
  s.homepage         = 'https://github.com/macookpro2100/mPaas'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DreamTracer' => 'jinqiucheng@live.cn' }
  s.source           = { :git => 'https://github.com/macookpro2100/mPaas.git', :tag => s.version.to_s }
  s.social_media_url = 'http://www.jianshu.com/u/macookpro2100'
  s.ios.deployment_target = '8.0'
  s.source_files = ['mPaas/Classes/**/*', 'mPaas/Classes/**/*.{h,m,mm}']

  s.vendored_frameworks = [
                              'mPaas/*/*.framework',
                              
                      ]
  s.frameworks = 'CoreTelephony', 'SystemConfiguration' ,'Accelerate','SystemConfiguration'
  s.libraries = 'xml2', 'sqlite3', 'resolv', 'z', 'stdc++'
   
  
  s.prefix_header_contents = <<-EOS
    
    EOS
  s.resource_bundles = {
      'mPaas' => ['mPaas/Assets/*.{png,json,mp3,m4a,plist}','mPaas/Assets/**/*']
    }

end

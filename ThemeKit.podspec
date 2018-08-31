Pod::Spec.new do |s|
	s.name                    = 'ThemeKit'
	s.version                 = '1.0'
	s.summary                 = 'Library for theming an iOS application easily'

	s.homepage                = 'https://pilgrimagesoftware.com'
	s.license                 = { type: 'MIT', file: 'LICENSE' }
	s.author                  = { 'Paul Schifferer' => 'paul@schifferers.net' }
	s.social_media_url        = 'https://wanderingmonster.org'

	s.source                  = { git: 'https://github.com/paulyhedral/ThemeKit.git',
								  tag: s.version.to_s, submodules: true }
	s.frameworks              = 'Foundation'
	s.ios.frameworks          = 'UIKit'

	s.ios.deployment_target   = '10.0'

	s.requires_arc            = true

	s.source_files            = 'Sources/ThemeKit/**/*.{h,m,c,swift}'
    s.resources               = 'Sources/ThemeKit/**/*.strings'

	s.dependency              'SwiftyBeaver'
    s.dependency              'KBRoundedButton'
end

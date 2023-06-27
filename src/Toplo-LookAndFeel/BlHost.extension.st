Extension { #name : #BlHost }

{ #category : #'*Toplo-LookAndFeel' }
BlHost >> oblWorld [

	^ self universe spaces
		  detect: [ :sp | sp title = self oblWorldTitle ]
		  ifNone: [ | w |
				self flag:'labordep : temporary set a nil toTheme setup, this methods should be removed when Look&Feel management will be ok'.
			  w := OBlSpace new
				  toTheme: nil;
				  host: self;
				  title: self oblWorldTitle;
				  yourself.
				self universe attachSpace: w.
				w ]
]

Extension { #name : 'BlHost' }

{ #category : '*Toplo' }
BlHost >> oblWorld [

	^ self universe spaces
		  detect: [ :sp | sp title = 'OnBloc World' ]
		  ifNone: [ | w |
				self flag:'labordep : temporary set a nil toTheme setup, this methods should be removed when Look&Feel management will be ok'.
			  w := BlSpace new
				  toTheme: nil;
				  host: self;
				  title: 'OnBloc World' ;
				  yourself.
				self universe attachSpace: w.
				w ]
]

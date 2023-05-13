Extension { #name : #OBlSpace }

{ #category : #'*Toplo-LookAndFeel' }
OBlSpace >> switchThemeDarkOrLight [
	"Switch to the opposite theme : dark or light (if available)"

	self toTheme ifNil:[ ^ self ].
	self toTheme: (self toTheme isLight
			 ifTrue: [ self toTheme darkTheme ]
			 ifFalse: [ self toTheme lightTheme ])
]

{ #category : #'*Toplo-LookAndFeel' }
OBlSpace >> toTheme [

	^ self root toTheme
]

{ #category : #'*Toplo-LookAndFeel' }
OBlSpace >> toTheme: aTheme [

	self root toTheme: aTheme.
	
	"Update root background color depending theme"
	self flag:'labordep : this code should not be here but in a dresser dedicated to root element (to be coherent with dresser pattern)'.
	self root background: aTheme backgroundColor.
]

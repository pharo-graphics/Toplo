Extension { #name : #OBlSpace }

{ #category : #'*Toplo' }
OBlSpace >> switchThemeDarkOrLight [
	"Switch to the opposite theme : dark or light (if available)"

	self toTheme ifNil:[ ^ self ].
	self toTheme: (self toTheme isLight
			 ifTrue: [ self toTheme darkTheme ]
			 ifFalse: [ self toTheme lightTheme ])
]

{ #category : #'*Toplo' }
OBlSpace >> toTheme [

	^ self root toTheme
]

{ #category : #'*Toplo' }
OBlSpace >> toTheme: aTheme [

	self root toTheme: aTheme.
	
	"update background color depending theme"
	self flag:'PLA : comment traiter ce cas qui nest pas un element toplo ?'.
	self root background: aTheme backgroundColor.
]

Extension { #name : #OBlSpace }

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

Extension { #name : #ToButton }

{ #category : #'*Toplo-LookAndFeel' }
ToButton >> skinType: aType [

	self dresser: (self toTheme class dresserFor: self).
	self skin: (self toTheme class skinFor: self type: aType)
]

{ #category : #'*Toplo-LookAndFeel' }
ToButton class >> skinType: aType [

	| e |
	self flag:'labordep : mettre dans ToElement ?'.
	e := super skinType: aType.
	e skinType: aType.
	^ e
]

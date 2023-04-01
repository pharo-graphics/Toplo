Extension { #name : #ToButton }

{ #category : #'*Toplo-LookAndFeel' }
ToButton class >> skinType: aType [

	| e |
	self flag:'labordep : mettre dans ToElement ?'.
	e := super skinType: aType.
	e skinType: aType.
	^ e
]

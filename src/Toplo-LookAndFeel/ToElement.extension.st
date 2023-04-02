Extension { #name : #ToElement }

{ #category : #'*Toplo-LookAndFeel' }
ToElement class >> skinType: aType [

	| e |
	e := self new.
	e skinType: aType.
	^ e
]

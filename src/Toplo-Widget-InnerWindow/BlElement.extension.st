Extension { #name : #BlElement }

{ #category : #'*Toplo-Widget-InnerWindow' }
BlElement >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame root addChild: self.
	frame openInSpace
]

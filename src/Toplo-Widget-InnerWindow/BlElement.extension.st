Extension { #name : #BlElement }

{ #category : #'*Toplo-Widget-InnerWindow' }
BlElement >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame pane addChild: self.
	frame openInSpace
]

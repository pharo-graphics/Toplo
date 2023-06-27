Trait {
	#name : #TToWorldElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - world element' }
TToWorldElement >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame root addChild: self.
	frame openInWorld
]

{ #category : #'t - world element' }
TToWorldElement >> openInWorld [

	| world |
	world := ToManager world.
	world isOpened ifFalse: [ world show ].
	world root addChild: self
]

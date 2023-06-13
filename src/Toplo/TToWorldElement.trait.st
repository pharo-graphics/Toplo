Trait {
	#name : #TToWorldElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - world element' }
TToWorldElement >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame root addChild: self.
	frame openInSpace
]

{ #category : #'t - world element' }
TToWorldElement >> openInWorld [

	self 
		deprecated:  'Use #openInSpace instead' 
		transformWith: '`@receiver openInWorld' -> '`@receiver openInSpace'.
	^ self openInSpace

]

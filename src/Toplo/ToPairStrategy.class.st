Class {
	#name : #ToPairStrategy,
	#superclass : #Object,
	#category : #'Toplo-Core-Pair'
}

{ #category : #layout }
ToPairStrategy >> childrenIn: aPair [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToPairStrategy >> columnWidth [

	^ 0
]

{ #category : #accessing }
ToPairStrategy >> isJustified [

	^ false
]

{ #category : #layout }
ToPairStrategy >> onMeasure: anExtentMeasurementSpec in: aPair [

	self subclassResponsibility 
]

{ #category : #layout }
ToPairStrategy >> updateChildrenIn: aPair [

	| subs |
	
	subs := self childrenIn: aPair.
	aPair children asArray = subs ifTrue: [ ^ self ].
	aPair eventDispatcher disableLayoutChanged.
	aPair removeChildren.
	aPair eventDispatcher enableLayoutChanged.
	aPair addChildren: subs
]

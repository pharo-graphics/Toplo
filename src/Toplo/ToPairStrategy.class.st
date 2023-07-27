Class {
	#name : #ToPairStrategy,
	#superclass : #Object,
	#category : #'Toplo-Core-Pair'
}

{ #category : #layout }
ToPairStrategy >> childrenIn: aPair [

	^ {
		  aPair first.
		  aPair second.
		  aPair extra } select: #notNil
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
ToPairStrategy >> updateChildrenIn: anElement [

	| subs |
	
	subs := self childrenIn: anElement.
	anElement children asArray = subs ifTrue: [ ^ self ].
	anElement removeChildren.
	anElement addChildren: subs
]

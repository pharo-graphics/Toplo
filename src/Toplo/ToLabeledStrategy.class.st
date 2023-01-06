Class {
	#name : #ToLabeledStrategy,
	#superclass : #Object,
	#category : #'Toplo-Core-Labeled'
}

{ #category : #layout }
ToLabeledStrategy >> childrenIn: aLabeled [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToLabeledStrategy >> columnWidth [

	^ 0
]

{ #category : #accessing }
ToLabeledStrategy >> isJustified [

	^ false
]

{ #category : #layout }
ToLabeledStrategy >> onMeasure: anExtentMeasurementSpec in: aLabeled [

	self subclassResponsibility 
]

{ #category : #layout }
ToLabeledStrategy >> updateChildrenIn: aLabeled [

	| subs |
	
	subs := self childrenIn: aLabeled.
	aLabeled children asArray = subs ifTrue: [ ^ self ].
	aLabeled eventDispatcher disableLayoutChanged.
	aLabeled removeChildren.
	aLabeled eventDispatcher enableLayoutChanged.
	aLabeled addChildren: subs
]

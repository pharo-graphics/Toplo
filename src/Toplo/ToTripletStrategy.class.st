Class {
	#name : #ToTripletStrategy,
	#superclass : #Object,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #layout }
ToTripletStrategy >> childrenIn: aPair [

	^ {
		  aPair first.
		  aPair second.
		  aPair third } select: #notNil
]

{ #category : #accessing }
ToTripletStrategy >> columnWidth [

	^ 0
]

{ #category : #accessing }
ToTripletStrategy >> isJustified [

	^ false
]

{ #category : #layout }
ToTripletStrategy >> onMeasure: anExtentMeasurementSpec in: aPair [

	self subclassResponsibility 
]

{ #category : #layout }
ToTripletStrategy >> updateChildrenIn: anElement [

	| subs |
	
	subs := self childrenIn: anElement.
	anElement children asArray = subs ifTrue: [ ^ self ].
	anElement removeChildren.
	anElement addChildren: subs
]

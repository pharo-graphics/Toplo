Trait {
	#name : #TToShrinkable,
	#category : #'Toplo-Core'
}

{ #category : #'t - shrinkable' }
TToShrinkable >> addShrinkFeedbackLayer [

	| layer |
	self shrinkFeedbackLayer ifNotNil: [ ^ self ].
	layer := ToShrinkFeedbackLayer new.
	layer id: #shrinkFeedbackLayer.
	layer attachTo: self.
	self addChild: layer
]

{ #category : #'t - shrinkable' }
TToShrinkable >> addShrinkFeedbackLayerWithReferenceParent: anElement [

	" an element is one of the parents of the receiver. 
	It is used to check the visibility of the shrink layer.
	If the size of the receiver is greater than the size of the 
	reference parent, then the receiver become visible"

	self shrinkFeedbackLayer ifNotNil: [ ^ self ].
	self addShrinkFeedbackLayer.
	self shrinkFeedbackLayer referenceParent: anElement
	
]

{ #category : #'t - shrinkable' }
TToShrinkable >> removeShrinkFeedbackLayer [

	| layer |
	layer := self shrinkFeedbackLayer ifNil: [ ^ self ].
	layer detach.
	self removeChild: layer
]

{ #category : #'t - shrinkable' }
TToShrinkable >> shrinkFeedbackLayer [

	^ self childWithId: #shrinkFeedbackLayer ifNone: [].
]

{ #category : #'t - shrinkable' }
TToShrinkable >> withShrinkFeedback: aBoolean [

	aBoolean
		ifTrue: [ self addShrinkFeedbackLayer ]
		ifFalse: [ self removeShrinkFeedbackLayer ]
]

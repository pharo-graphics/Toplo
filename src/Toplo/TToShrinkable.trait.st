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

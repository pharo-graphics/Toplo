Trait {
	#name : #TToShrinkable,
	#instVars : [
		'shrinkTolerance'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - shrinkable' }
TToShrinkable >> addShrinkFeedbackLayer [

	| layer |
	self shrinkFeedbackLayer ifNotNil: [ ^ self ].
	layer := ToShrinkFeedbackLayer new.
	layer id: #shrinkFeedbackLayer.
	layer attachTo: self.
	self addChild: layer.
	layer shrinked: self firstChild
]

{ #category : #'t - shrinkable' }
TToShrinkable >> applyShrinkableConfiguration [

	self shrinkFeedbackLayer ifNotNil: [ :layer |
		layer tolerance: self shrinkTolerance ]
]

{ #category : #'t - shrinkable' }
TToShrinkable >> enableShrinkLayer: aBoolean [

	aBoolean
		ifTrue: [
			self shrinkFeedbackLayer ifNotNil: [ ^ self ].
			self addShrinkFeedbackLayer ]
		ifFalse: [
			self shrinkFeedbackLayer ifNil: [ ^ self ].
			self removeShrinkFeedbackLayer ].
	self requestNewConfiguration
]

{ #category : #'t - shrinkable' }
TToShrinkable >> removeShrinkFeedbackLayer [

	| layer |
	layer := self shrinkFeedbackLayer ifNil: [ ^ self ].
	layer detach.
	self removeChild: layer.
	layer shrinked: nil
]

{ #category : #'t - shrinkable' }
TToShrinkable >> shrinkFeedbackLayer [

	^ self childWithId: #shrinkFeedbackLayer ifNone: [].
]

{ #category : #'t - shrinkable' }
TToShrinkable >> shrinkTolerance [

	^ shrinkTolerance ifNil: [ shrinkTolerance := 0.0 ]
]

{ #category : #'t - shrinkable' }
TToShrinkable >> shrinkTolerance: aNumber [

	shrinkTolerance := aNumber.
	self requestNewConfiguration 
]

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
	self addChild: layer.
	layer shrinked: self firstChild
]

{ #category : #'t - shrinkable' }
TToShrinkable >> enableShrinkLayer: aBoolean [

	aBoolean
		ifTrue: [
			self shrinkFeedbackLayer ifNotNil: [ ^ self ].
			self addShrinkFeedbackLayer ]
		ifFalse: [
			self shrinkFeedbackLayer ifNil: [ ^ self ].
			self removeShrinkFeedbackLayer ]
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

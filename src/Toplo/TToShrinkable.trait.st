Trait {
	#name : #TToShrinkable,
	#instVars : [
		'shrinkTolerance',
		'checkedOrientation'
	],
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'t - shrinkable' }
TToShrinkable >> addShrinkFeedbackLayer [

	| layer |
	self shrinkFeedbackLayer ifNotNil: [ ^ self ].
	layer := ToGradientShrinkFeedbackLayer new.
	layer id: #shrinkFeedbackLayer.
	layer attachTo: self.
	self addChild: layer.

]

{ #category : #'t - shrinkable' }
TToShrinkable >> applyShrinkableConfiguration [

	self shrinkFeedbackLayer ifNotNil: [ :layer |
		layer tolerance: self shrinkTolerance.
		layer checkedOrientation: self checkedOrientation.
		(self children detect: [ :child | child ~= layer ] ifNone: [  ])
			ifNotNil: [ :shrinked | layer shrinked: shrinked ] ]
]

{ #category : #'t - shrinkable' }
TToShrinkable >> checkHorizontally [

	self checkedOrientation: BlLayoutOrientation horizontal
]

{ #category : #'t - shrinkable' }
TToShrinkable >> checkVertically [

	self checkedOrientation: BlLayoutOrientation vertical
]

{ #category : #'t - shrinkable' }
TToShrinkable >> checkedOrientation [

	^ checkedOrientation ifNil: [
		  checkedOrientation := BlLayoutOrientation horizontal ]
]

{ #category : #'t - shrinkable' }
TToShrinkable >> checkedOrientation: anOrientation [

	checkedOrientation := anOrientation.
	self requestNewConfiguration
]

{ #category : #'t - shrinkable' }
TToShrinkable >> enableShrinkLayer: aBoolean [

	aBoolean
		ifTrue: [
		self shrinkFeedbackLayer ifNil: [ self addShrinkFeedbackLayer ] ]
		ifFalse: [
			self shrinkFeedbackLayer ifNotNil: [
				self removeShrinkFeedbackLayer ] ]
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

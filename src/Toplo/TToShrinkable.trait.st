Trait {
	#name : #TToShrinkable,
	#instVars : [
		'shrinkTolerance',
		'checkedShrinkabilityOrientation'
	],
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'t - shrinkable' }
TToShrinkable >> addShrinkFeedbackLayer [

	| layer |
	self shrinkFeedbackLayer ifNotNil: [ ^ self ].
	layer := ToGradientShrinkFeedbackLayer new.
	layer id: #shrinkFeedbackLayer.
	layer attachToParent: self.
	layer visibility: BlVisibility hidden
]

{ #category : #'t - shrinkable' }
TToShrinkable >> applyShrinkableConfiguration [

	self shrinkFeedbackLayer ifNotNil: [ :layer |
		layer tolerance: self shrinkTolerance.
		layer checkedShrinkabilityOrientation: self checkedShrinkabilityOrientation.
		(self children detect: [ :child | child ~= layer ] ifNone: [  ])
			ifNotNil: [ :shrinked | layer shrinked: shrinked ] ]
]

{ #category : #'t - shrinkable' }
TToShrinkable >> checkHorizontalShrinkability [

	self enableShrinkLayer: true.
	self checkedShrinkabilityOrientation: BlLayoutOrientation horizontal
]

{ #category : #'t - shrinkable' }
TToShrinkable >> checkVerticalShrinkability [

	self enableShrinkLayer: true.
	self checkedShrinkabilityOrientation: BlLayoutOrientation vertical
]

{ #category : #'t - shrinkable' }
TToShrinkable >> checkedShrinkabilityOrientation [

	^ checkedShrinkabilityOrientation ifNil: [
		  checkedShrinkabilityOrientation := BlLayoutOrientation horizontal ]
]

{ #category : #'t - shrinkable' }
TToShrinkable >> checkedShrinkabilityOrientation: anOrientation [

	checkedShrinkabilityOrientation := anOrientation.
	self requestConfiguration
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
TToShrinkable >> isShrinked [

	^ self shrinkFeedbackLayer
		  ifNil: [ false ]
		  ifNotNil: [ :layer | layer isVisible ]
]

{ #category : #'t - shrinkable' }
TToShrinkable >> removeShrinkFeedbackLayer [

	| layer |
	layer := self shrinkFeedbackLayer ifNil: [ ^ self ].
	layer detachFromParent.
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
	self requestConfiguration 
]

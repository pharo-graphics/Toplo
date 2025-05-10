Class {
	#name : #ToShrinkFeedbackLayer,
	#superclass : #ToOverlayElement,
	#instVars : [
		'shrinked',
		'shrinkedHandler',
		'tolerance',
		'checkedOrientation'
	],
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'private - geometry' }
ToShrinkFeedbackLayer >> checkVisibility [

	| pbnds ebnds gap |
	shrinked ifNil: [ ^ self ].
	pbnds := referenceElement bounds inSpace asRectangle.
	ebnds := shrinked bounds inSpace asRectangle.
	gap := checkedOrientation isHorizontal
		       ifTrue: [ pbnds width - ebnds width ]
		       ifFalse: [ pbnds height - ebnds height ].
	gap >= tolerance negated
		ifTrue: [ self visibility: BlVisibility hidden ]
		ifFalse: [
			self visibility: BlVisibility visible.
			self requestNewSkin ]
]

{ #category : #accessing }
ToShrinkFeedbackLayer >> checkedShrinkabilityOrientation [

	^ checkedOrientation
]

{ #category : #accessing }
ToShrinkFeedbackLayer >> checkedShrinkabilityOrientation: anOrientation [

	checkedOrientation := anOrientation.
	self checkVisibility 
]

{ #category : #'api - attaching / detaching' }
ToShrinkFeedbackLayer >> detach [

	super detach.
	shrinked ifNil: [ ^ self ].
	shrinked removeEventHandler: shrinkedHandler.
	shrinkedHandler layer: nil.
	shrinked := nil.
	shrinkedHandler := nil
]

{ #category : #initialization }
ToShrinkFeedbackLayer >> initialize [

	super initialize.
	self initializeForToplo.
	tolerance := 0.0.
	checkedOrientation := BlLayoutOrientation horizontal.
	self elevation: (BlRelativeElevation elevation: 1).
]

{ #category : #initialization }
ToShrinkFeedbackLayer >> newOverlayListener [ 

	^ ToShrinkFeedbackListener for: self
]

{ #category : #accessing }
ToShrinkFeedbackLayer >> shrinked [

	^ shrinked
]

{ #category : #accessing }
ToShrinkFeedbackLayer >> shrinked: anElement [

	anElement = self ifTrue: [ ^ self ].
	shrinked = anElement ifTrue: [ ^ self ].
	shrinked ifNotNil: [ shrinked removeEventHandler: shrinkedHandler ].
	shrinked := anElement.
	shrinked ifNotNil: [
		shrinkedHandler := ToShrinkedListener new
			                   layer: self;
			                   yourself.
		shrinked addEventHandler: shrinkedHandler ].
	self checkVisibility 
]

{ #category : #accessing }
ToShrinkFeedbackLayer >> tolerance: aNumber [

	tolerance = aNumber ifTrue: [ ^ self ].
	tolerance := aNumber.
	self checkVisibility 
]

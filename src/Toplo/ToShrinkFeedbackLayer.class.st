Class {
	#name : #ToShrinkFeedbackLayer,
	#superclass : #ToOverlayElement,
	#instVars : [
		'shrinked',
		'shrinkedHandler',
		'tolerance'
	],
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'hook - geometry' }
ToShrinkFeedbackLayer >> checkVisibility [

	| pbnds ebnds |
	shrinked ifNil: [ ^ self ].
	pbnds := referenceElement bounds inSpace asRectangle.
	ebnds := shrinked bounds inSpace asRectangle.
	pbnds width - ebnds width > tolerance negated 
		ifTrue: [ self visibility: BlVisibility hidden ]
		ifFalse: [
			self visibility: BlVisibility visible.
			self requestNewSkin ]
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
	tolerance := 0.0
]

{ #category : #initialization }
ToShrinkFeedbackLayer >> newOverlayListener [ 

	^ ToShrinkFeedbackListener for: self
]

{ #category : #'instance creation' }
ToShrinkFeedbackLayer >> newRawSkin [ 

	^ ToShrinkFeedbackLayerSkin new
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
		shrinked addEventHandler: shrinkedHandler ]
]

{ #category : #accessing }
ToShrinkFeedbackLayer >> tolerance: aNumber [

	tolerance := aNumber
]

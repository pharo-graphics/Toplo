Class {
	#name : #ToShrinkFeedbackLayer,
	#superclass : #ToOverlayElement,
	#instVars : [
		'precision',
		'shrinked',
		'shrinkedHandler'
	],
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'hook - geometry' }
ToShrinkFeedbackLayer >> checkVisibility [

	| pbnds ebnds |
	shrinked ifNil: [ ^ self ].
	pbnds := referenceElement bounds inSpace asRectangle.
	ebnds := shrinked bounds inSpace asRectangle.
	pbnds width - ebnds width > precision negated 
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
	precision := 1.0
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
ToShrinkFeedbackLayer >> shrinked: anElement [

	shrinked = anElement ifTrue: [ ^ self ].
	shrinked ifNotNil: [ shrinked removeEventHandler: shrinkedHandler ].
	shrinked := anElement.
	shrinked ifNotNil: [
		shrinkedHandler := ToShrinkedListener new
			                   layer: self;
			                   yourself.
		shrinked addEventHandler: shrinkedHandler ]
]

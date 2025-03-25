Class {
	#name : #ToShrinkFeedbackLayer,
	#superclass : #ToOverlayElement,
	#instVars : [
		'referenceParent'
	],
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'hook - geometry' }
ToShrinkFeedbackLayer >> checkVisibility [

	| pbnds ebnds |
	referenceParent ifNil: [ ^ self ].
	pbnds := referenceParent bounds inSpace asRectangle.
	ebnds := referenceElement bounds inSpace asRectangle.
	(pbnds intersect: ebnds) = ebnds
		ifTrue: [ self visibility: BlVisibility hidden ]
		ifFalse: [
			self visibility: BlVisibility visible.
			"self size: referenceParent size."
			self requestNewSkin ]
]

{ #category : #'hook - geometry' }
ToShrinkFeedbackLayer >> extentFrom: anExtent [

	| size |
	size := super extentFrom: anExtent.
	^ size
	"referenceParent ifNil: [ ^ size ].
	^ size min: referenceParent size"
]

{ #category : #initialization }
ToShrinkFeedbackLayer >> initialize [

	super initialize.
	self initializeForToplo.
	self preventMeAndChildrenMouseEvents
]

{ #category : #'instance creation' }
ToShrinkFeedbackLayer >> newRawSkin [ 

	^ ToShrinkFeedbackLayerSkin new
]

{ #category : #accessing }
ToShrinkFeedbackLayer >> referenceParent [

	^ referenceParent 
]

{ #category : #accessing }
ToShrinkFeedbackLayer >> referenceParent: anElement [

	referenceParent ifNotNil: [ BlImmutableObjectChangeError signal ].
	referenceParent := anElement.
	referenceParent
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :event | self checkVisibility ]
]

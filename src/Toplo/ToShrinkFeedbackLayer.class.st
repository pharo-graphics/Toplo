Class {
	#name : #ToShrinkFeedbackLayer,
	#superclass : #ToOverlayElement,
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'hook - geometry' }
ToShrinkFeedbackLayer >> checkVisibility [

	| pbnds ebnds |
	pbnds := referenceElement bounds inSpace asRectangle.
	ebnds := referenceElement firstChild bounds inSpace asRectangle.

	(pbnds containsRect: ebnds) 
		ifTrue: [
				pbnds trace. ' ' trace. ebnds trace. ' ' trace. (pbnds intersect: ebnds) traceCr.
			 self visibility: BlVisibility hidden ]
		ifFalse: [
			self visibility: BlVisibility visible.
			self requestNewSkin ]
]

{ #category : #initialization }
ToShrinkFeedbackLayer >> initialize [

	super initialize.
	self initializeForToplo.
	self preventMeAndChildrenMouseEvents.
	self addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :event | self checkVisibility ]
]

{ #category : #'instance creation' }
ToShrinkFeedbackLayer >> newRawSkin [ 

	^ ToShrinkFeedbackLayerSkin new
]

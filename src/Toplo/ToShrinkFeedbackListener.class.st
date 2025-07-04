Class {
	#name : #ToShrinkFeedbackListener,
	#superclass : #BlOverlayListener,
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'element handlers' }
ToShrinkFeedbackListener >> elementExtentChangedEvent: anEvent [

	super elementExtentChangedEvent: anEvent.
	overlayElement checkVisibility 
]

{ #category : #'element handlers' }
ToShrinkFeedbackListener >> elementTransformationInSpaceChangedEvent: anEvent [

	super elementTransformationInSpaceChangedEvent: anEvent.
	overlayElement checkVisibility 
]

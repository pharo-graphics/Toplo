Class {
	#name : #ToShrinkedListener,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'layer'
	],
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'element handlers' }
ToShrinkedListener >> elementExtentChangedEvent: anEvent [

	layer whenLayoutedDoOnce: [ layer checkVisibility ]
]

{ #category : #'element handlers' }
ToShrinkedListener >> elementPositionInSpaceChangedEvent: anEvent [

	layer whenLayoutedDoOnce: [ layer checkVisibility ]
]

{ #category : #'element handlers' }
ToShrinkedListener >> elementTransformationInSpaceChangedEvent: anEvent [

	layer whenLayoutedDoOnce: [ layer checkVisibility ]
]

{ #category : #'api - accessing' }
ToShrinkedListener >> eventsToHandle [

	^ {
		  BlElementExtentChangedEvent.
		  BlElementPositionInSpaceChangedEvent.
		  BlElementTransformationInSpaceChangedEvent }
]

{ #category : #accessing }
ToShrinkedListener >> layer: aShrinkFeedbackLayer [

	layer := aShrinkFeedbackLayer 
]

Class {
	#name : #ToElementWithAnchoredWindowManagerTestEventHandler,
	#superclass : #ToAnchorEventHandler,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #'api - accessing' }
ToElementWithAnchoredWindowManagerTestEventHandler >> windowEventsToHandle [

	^ {
		  ToAnchoredWindowOpenRequest.
		  ToAnchoredWindowForTestClosedEvent.
		  ToAnchoredWindowForTestOpenedEvent }
]

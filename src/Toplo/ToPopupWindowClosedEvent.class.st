Class {
	#name : #ToPopupWindowClosedEvent,
	#superclass : #ToAnchoredWindowClosedEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToPopupWindowClosedEvent >> sendTo: anObject [

	anObject popupWindowClosedEvent: self
]

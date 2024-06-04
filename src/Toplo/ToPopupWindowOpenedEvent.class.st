Class {
	#name : #ToPopupWindowOpenedEvent,
	#superclass : #ToAnchoredWindowOpenedEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToPopupWindowOpenedEvent >> sendTo: anObject [

	anObject popupWindowOpenedEvent: self
]

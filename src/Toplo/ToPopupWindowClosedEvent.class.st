Class {
	#name : #ToPopupWindowClosedEvent,
	#superclass : #ToWindowClosedEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToPopupWindowClosedEvent >> sendTo: anObject [

	anObject popupWindowClosedEvent: self
]

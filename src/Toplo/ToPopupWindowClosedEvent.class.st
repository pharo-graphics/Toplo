Class {
	#name : #ToPopupWindowClosedEvent,
	#superclass : #ToClosedEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToPopupWindowClosedEvent >> sendTo: anObject [

	anObject popupWindowClosedEvent: self
]

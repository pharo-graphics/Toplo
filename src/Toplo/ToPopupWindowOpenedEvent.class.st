Class {
	#name : #ToPopupWindowOpenedEvent,
	#superclass : #ToWindowOpenedEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToPopupWindowOpenedEvent >> sendTo: anObject [

	anObject popupWindowOpenedEvent: self
]

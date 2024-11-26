Class {
	#name : #ToPopupWindowOpenedEvent,
	#superclass : #ToOpenedEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToPopupWindowOpenedEvent >> sendTo: anObject [

	anObject popupWindowOpenedEvent: self
]

Class {
	#name : #ToMenuWindowOpenedEvent,
	#superclass : #ToAnchoredWindowOpenedEvent,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #sending }
ToMenuWindowOpenedEvent >> sendTo: anObject [

	anObject menuWindowOpenedEvent: self
]

Class {
	#name : #ToMenuWindowClosedEvent,
	#superclass : #ToAnchoredWindowClosedEvent,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #sending }
ToMenuWindowClosedEvent >> sendTo: anObject [

	anObject menuWindowClosedEvent: self
]

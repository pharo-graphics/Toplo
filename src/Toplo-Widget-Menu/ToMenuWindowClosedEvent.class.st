Class {
	#name : #ToMenuWindowClosedEvent,
	#superclass : #ToWindowClosedEvent,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #sending }
ToMenuWindowClosedEvent >> sendTo: anObject [

	anObject menuWindowClosedEvent: self
]

Class {
	#name : #ToMenuWindowOpenedEvent,
	#superclass : #ToWindowOpenedEvent,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #sending }
ToMenuWindowOpenedEvent >> sendTo: anObject [

	anObject menuWindowOpenedEvent: self
]

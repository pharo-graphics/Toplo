Class {
	#name : #ToTextEmptinessChangeEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-Album'
}

{ #category : #sending }
ToTextEmptinessChangeEvent >> sendTo: anObject [

	anObject textEmptinessChangeEvent: self
]

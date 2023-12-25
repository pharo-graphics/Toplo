Class {
	#name : #ToTextEmptinessChangeEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Widget-Album-TextPane'
}

{ #category : #sending }
ToTextEmptinessChangeEvent >> sendTo: anObject [

	anObject textEmptinessChangeEvent: self
]

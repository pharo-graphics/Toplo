Class {
	#name : #ToDataEmptinessChangeEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToDataEmptinessChangeEvent >> sendTo: anObject [

	anObject dataEmptinessChangeEvent: self
]

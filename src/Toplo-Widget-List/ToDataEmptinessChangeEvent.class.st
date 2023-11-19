Class {
	#name : #ToDataEmptinessChangeEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Widget-List-infinite'
}

{ #category : #sending }
ToDataEmptinessChangeEvent >> sendTo: anObject [

	anObject dataEmptinessChangeEvent: self
]

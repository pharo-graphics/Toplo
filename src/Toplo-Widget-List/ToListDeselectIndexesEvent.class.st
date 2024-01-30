Class {
	#name : #ToListDeselectIndexesEvent,
	#superclass : #ToListMultipleIndexesEvent,
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListDeselectIndexesEvent class >> isDeprecated [

	^ true
]

{ #category : #sending }
ToListDeselectIndexesEvent >> sendTo: anObject [

	anObject listDeselectIndexesEvent: self
]

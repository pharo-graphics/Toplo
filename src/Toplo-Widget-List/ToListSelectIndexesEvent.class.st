Class {
	#name : #ToListSelectIndexesEvent,
	#superclass : #ToListMultipleIndexesEvent,
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListSelectIndexesEvent class >> isDeprecated [

	^ true
]

{ #category : #sending }
ToListSelectIndexesEvent >> sendTo: anObject [

	anObject listSelectIndexesEvent: self
]

Class {
	#name : #ToListRemoveSelectedIndexesEvent,
	#superclass : #ToListIndexGroupEvent,
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListRemoveSelectedIndexesEvent class >> isDeprecated [

	^ true
]

{ #category : #sending }
ToListRemoveSelectedIndexesEvent >> sendTo: anObject [

	anObject listRemoveSelectedIndexesEvent: self
]

Class {
	#name : #ToListRemoveSelectedIndexesEvent,
	#superclass : #ToListIndexGroupEvent,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #sending }
ToListRemoveSelectedIndexesEvent >> sendTo: anObject [

	anObject listRemoveSelectedIndexesEvent: self
]

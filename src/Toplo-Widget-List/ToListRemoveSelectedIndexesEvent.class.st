Class {
	#name : #ToListRemoveSelectedIndexesEvent,
	#superclass : #ToListIndexGroupEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToListRemoveSelectedIndexesEvent >> sendTo: anObject [

	anObject listRemoveSelectedIndexesEvent: self
]

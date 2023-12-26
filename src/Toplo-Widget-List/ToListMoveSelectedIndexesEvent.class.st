Class {
	#name : #ToListMoveSelectedIndexesEvent,
	#superclass : #ToListIndexGroupEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToListMoveSelectedIndexesEvent >> sendTo: anObject [

	anObject listMoveSelectedIndexesEvent: self
]

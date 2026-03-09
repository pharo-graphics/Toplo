Class {
	#name : #ToItemAddedInListEvent,
	#superclass : #ToListItemEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToItemAddedInListEvent >> sendTo: anObject [

	anObject itemAddedInListEvent: self
]

Class {
	#name : #ToItemAddedInListEvent,
	#superclass : #ToListItemEvent,
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #sending }
ToItemAddedInListEvent >> sendTo: anObject [

	anObject itemAddedInListEvent: self
]

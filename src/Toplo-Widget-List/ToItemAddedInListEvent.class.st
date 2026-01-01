Class {
	#name : #ToItemAddedInListEvent,
	#superclass : #ToListItemEvent,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #sending }
ToItemAddedInListEvent >> sendTo: anObject [

	anObject itemAddedInListEvent: self
]

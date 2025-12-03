Class {
	#name : #ToItemAddedInFiniteListEvent,
	#superclass : #ToFiniteListItemEvent,
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #sending }
ToItemAddedInFiniteListEvent >> sendTo: anObject [

	anObject itemAddedInBarEvent: self
]

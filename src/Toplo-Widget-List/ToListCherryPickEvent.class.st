Class {
	#name : #ToListCherryPickEvent,
	#superclass : #ToListUniqueIndexEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToListCherryPickEvent >> sendTo: anObject [

	anObject listCherryPickEvent: self
]

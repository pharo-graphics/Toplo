Class {
	#name : #ToListSelectIndexOnlyEvent,
	#superclass : #ToListUniqueIndexEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToListSelectIndexOnlyEvent >> sendTo: anObject [

	anObject listSelectIndexEvent: self
]

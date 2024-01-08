Class {
	#name : #ToListSelectIndexOnlyEvent,
	#superclass : #ToListUniqueIndexEvent,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #sending }
ToListSelectIndexOnlyEvent >> sendTo: anObject [

	anObject listSelectIndexOnlyEvent: self
]

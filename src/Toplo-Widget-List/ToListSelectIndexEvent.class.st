Class {
	#name : #ToListSelectIndexEvent,
	#superclass : #ToListUniqueIndexEvent,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #sending }
ToListSelectIndexEvent >> sendTo: anObject [

	anObject listSelectIndexEvent: self
]

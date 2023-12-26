Class {
	#name : #ToListSelectIndexEvent,
	#superclass : #ToListUniqueIndexEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToListSelectIndexEvent >> sendTo: anObject [

	anObject listSelectIndexEvent: self
]

Class {
	#name : #ToListSelectIndexesEvent,
	#superclass : #ToListMultipleIndexesEvent,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #sending }
ToListSelectIndexesEvent >> sendTo: anObject [

	anObject listSelectIndexesEvent: self
]

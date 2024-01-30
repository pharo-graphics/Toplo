Class {
	#name : #ToListSelectIndexEvent,
	#superclass : #ToListUniqueIndexEvent,
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListSelectIndexEvent class >> isDeprecated [

	^ true
]

{ #category : #sending }
ToListSelectIndexEvent >> sendTo: anObject [

	anObject listSelectIndexEvent: self
]

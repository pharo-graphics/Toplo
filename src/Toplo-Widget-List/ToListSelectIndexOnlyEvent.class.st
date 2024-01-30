Class {
	#name : #ToListSelectIndexOnlyEvent,
	#superclass : #ToListUniqueIndexEvent,
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListSelectIndexOnlyEvent class >> isDeprecated [

	^ true
]

{ #category : #sending }
ToListSelectIndexOnlyEvent >> sendTo: anObject [

	anObject listSelectIndexOnlyEvent: self
]

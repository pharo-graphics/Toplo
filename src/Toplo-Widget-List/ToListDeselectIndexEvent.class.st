Class {
	#name : #ToListDeselectIndexEvent,
	#superclass : #ToListUniqueIndexEvent,
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListDeselectIndexEvent class >> isDeprecated [

	^ true
]

{ #category : #sending }
ToListDeselectIndexEvent >> sendTo: anObject [

	anObject listDeselectIndexEvent: self
]

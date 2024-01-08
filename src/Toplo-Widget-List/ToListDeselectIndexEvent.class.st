Class {
	#name : #ToListDeselectIndexEvent,
	#superclass : #ToListUniqueIndexEvent,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #sending }
ToListDeselectIndexEvent >> sendTo: anObject [

	anObject listDeselectIndexEvent: self
]

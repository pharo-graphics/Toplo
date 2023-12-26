Class {
	#name : #ToListDeselectIndexEvent,
	#superclass : #ToListUniqueIndexEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToListDeselectIndexEvent >> sendTo: anObject [

	anObject listDeselectIndexEvent: self
]

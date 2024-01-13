Class {
	#name : #ToListDeselectIndexesEvent,
	#superclass : #ToListMultipleIndexesEvent,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #sending }
ToListDeselectIndexesEvent >> sendTo: anObject [

	anObject listDeselectIndexesEvent: self
]

Class {
	#name : #ToListScrollFinishedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListScrollFinishedEvent >> sendTo: anObject [

	anObject listScrollFinishedEvent: self
]

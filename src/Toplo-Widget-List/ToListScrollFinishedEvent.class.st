Class {
	#name : #ToListScrollFinishedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #sending }
ToListScrollFinishedEvent >> sendTo: anObject [

	anObject listScrollFinishedEvent: self
]

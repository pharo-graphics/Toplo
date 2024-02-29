Class {
	#name : #ToInfiniteScrollFinishedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToInfiniteScrollFinishedEvent >> sendTo: anObject [

	anObject infiniteScrollFinishedEvent: self
]

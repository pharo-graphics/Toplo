Class {
	#name : #ToInfiniteScrollFinishedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #sending }
ToInfiniteScrollFinishedEvent >> sendTo: anObject [

	anObject infiniteScrollFinishedEvent: self
]

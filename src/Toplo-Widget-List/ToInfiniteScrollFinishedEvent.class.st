Class {
	#name : #ToInfiniteScrollFinishedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-InnerInfiniteList'
}

{ #category : #sending }
ToInfiniteScrollFinishedEvent >> sendTo: anObject [

	anObject infiniteScrollFinishedEvent: self
]

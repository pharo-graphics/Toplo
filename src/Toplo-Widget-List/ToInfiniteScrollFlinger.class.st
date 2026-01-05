Class {
	#name : #ToInfiniteScrollFlinger,
	#superclass : #BlInfiniteScrollFlinger,
	#category : #'Toplo-Widget-List-InnerInfiniteList'
}

{ #category : #hooks }
ToInfiniteScrollFlinger >> onFinished [

	super onFinished.
	scrollable dispatchEvent: ToInfiniteScrollFinishedEvent new
]

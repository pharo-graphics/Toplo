Class {
	#name : #ToInfiniteScrollFlinger,
	#superclass : #BlInfiniteScrollFlinger,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #hooks }
ToInfiniteScrollFlinger >> onFinished [

	super onFinished.
	scrollable dispatchEvent: ToInfiniteScrollFinishedEvent new
]

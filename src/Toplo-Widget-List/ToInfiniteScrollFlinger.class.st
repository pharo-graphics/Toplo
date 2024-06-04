Class {
	#name : #ToInfiniteScrollFlinger,
	#superclass : #BlInfiniteScrollFlinger,
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #hooks }
ToInfiniteScrollFlinger >> onFinished [

	super onFinished.
	scrollable dispatchEvent: ToInfiniteScrollFinishedEvent new
]

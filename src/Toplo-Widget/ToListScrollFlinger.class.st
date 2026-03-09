Class {
	#name : #ToListScrollFlinger,
	#superclass : #BlInfiniteScrollFlinger,
	#category : #'Toplo-Widget-List'
}

{ #category : #hooks }
ToListScrollFlinger >> onFinished [

	super onFinished.
	scrollable dispatchEvent: ToListScrollFinishedEvent new
]

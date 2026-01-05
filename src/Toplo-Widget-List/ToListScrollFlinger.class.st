Class {
	#name : #ToListScrollFlinger,
	#superclass : #BlInfiniteScrollFlinger,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #hooks }
ToListScrollFlinger >> onFinished [

	super onFinished.
	scrollable dispatchEvent: ToListScrollFinishedEvent new
]

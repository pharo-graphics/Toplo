Class {
	#name : #ToAnchoredWindowManagerForTest,
	#superclass : #ToAnchoredWindowManager,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindowManagerForTest >> windowClosedEventClass [

	^ ToAnchoredWindowForTestClosedEvent
]

{ #category : #accessing }
ToAnchoredWindowManagerForTest >> windowOpenedEventClass [

	^ ToAnchoredWindowForTestOpenedEvent
]

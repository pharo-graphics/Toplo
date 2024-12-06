Class {
	#name : #ToClosedEvent,
	#superclass : #ToOpenedClosedEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToClosedEvent >> sendTo: anObject [

	anObject closedEvent: self
]

{ #category : #sending }
ToClosedEvent >> sendToSkinStateGenerator: aSkinStateGenerator [

	aSkinStateGenerator closedEvent: self
]

{ #category : #sending }
ToClosedEvent >> sendToWindowManager: aWindowManager [

	aWindowManager closedEvent: self
]

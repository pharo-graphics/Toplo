Class {
	#name : #ToOpenedEvent,
	#superclass : #ToOpenedClosedEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToOpenedEvent >> sendTo: anObject [

	anObject openedEvent: self
]

{ #category : #sending }
ToOpenedEvent >> sendToSkinStateGenerator: aSkinStateGenerator [

	aSkinStateGenerator openedEvent: self
]

{ #category : #sending }
ToOpenedEvent >> sendToWindowManager: aWindowManager [

	aWindowManager openedEvent: self
]

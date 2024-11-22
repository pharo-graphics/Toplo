Class {
	#name : #ToWindowClosedEvent,
	#superclass : #ToWindowEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToWindowClosedEvent >> sendTo: anObject [

	anObject windowClosedEvent: self
]

{ #category : #sending }
ToWindowClosedEvent >> sendToSkinStateGenerator: aSkinStateGenerator [

	aSkinStateGenerator windowClosedEvent: self
]

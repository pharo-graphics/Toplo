Class {
	#name : #ToWindowOpenedEvent,
	#superclass : #ToWindowEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToWindowOpenedEvent >> sendTo: anObject [

	anObject windowOpenedEvent: self
]

{ #category : #sending }
ToWindowOpenedEvent >> sendToSkinStateGenerator: aSkinStateGenerator [

	aSkinStateGenerator windowOpenedEvent: self
]

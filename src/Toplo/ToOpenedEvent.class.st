Class {
	#name : #ToOpenedEvent,
	#superclass : #ToRelationShipWithSpaceEvent,
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

Class {
	#name : #ToClosedEvent,
	#superclass : #ToRelationShipWithSpaceEvent,
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

Class {
	#name : #ToRemovedFromSpaceEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToRemovedFromSpaceEvent >> sendTo: anObject [

	anObject removedFromSpaceEvent: self
]

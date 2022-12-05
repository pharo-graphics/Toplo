Class {
	#name : #ToAfterStateChangeAnnouncement,
	#superclass : #ToStateAnnouncement,
	#instVars : [
		'previousState'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToAfterStateChangeAnnouncement >> previousState [

	^ previousState
]

{ #category : #accessing }
ToAfterStateChangeAnnouncement >> previousState: aState [

	previousState := aState
]

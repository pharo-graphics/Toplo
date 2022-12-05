Class {
	#name : #ToEnterStateAnnouncement,
	#superclass : #ToStateAnnouncement,
	#instVars : [
		'previousState'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToEnterStateAnnouncement >> previousState [

	^ previousState
]

{ #category : #accessing }
ToEnterStateAnnouncement >> previousState: aState [

	previousState := aState
]

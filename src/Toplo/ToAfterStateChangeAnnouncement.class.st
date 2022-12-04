Class {
	#name : #ToAfterStateChangeAnnouncement,
	#superclass : #ToWidgetAnnouncement,
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

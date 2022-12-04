Class {
	#name : #ToEnterStateAnnouncement,
	#superclass : #ToWidgetAnnouncement,
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

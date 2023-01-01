Class {
	#name : #ToSelectAnnouncement,
	#superclass : #ToSelectionModelChanged,
	#instVars : [
		'event'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToSelectAnnouncement >> event [

	^ event
]

{ #category : #accessing }
ToSelectAnnouncement >> event: anEvent [

	event := anEvent
]

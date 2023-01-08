Class {
	#name : #ToEventOnNodeAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'holder',
		'event'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #accessing }
ToEventOnNodeAnnouncement >> event [

	^ event
]

{ #category : #accessing }
ToEventOnNodeAnnouncement >> event: anEvent [

	event := anEvent
]

{ #category : #accessing }
ToEventOnNodeAnnouncement >> holder [

	^ holder
]

{ #category : #accessing }
ToEventOnNodeAnnouncement >> holder: anHolder [

	holder := anHolder
]

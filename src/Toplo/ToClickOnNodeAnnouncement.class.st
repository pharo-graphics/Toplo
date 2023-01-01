Class {
	#name : #ToClickOnNodeAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'holder',
		'event'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #accessing }
ToClickOnNodeAnnouncement >> event [

	^ event
]

{ #category : #accessing }
ToClickOnNodeAnnouncement >> event: anEvent [

	event := anEvent
]

{ #category : #accessing }
ToClickOnNodeAnnouncement >> holder [

	^ holder
]

{ #category : #accessing }
ToClickOnNodeAnnouncement >> holder: anHolder [

	holder := anHolder
]

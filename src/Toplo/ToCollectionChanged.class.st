Class {
	#name : #ToCollectionChanged,
	#superclass : #Announcement,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToCollectionChanged >> interval [

	^ interval
]

{ #category : #accessing }
ToCollectionChanged >> interval: anInterval [

	interval := anInterval
]

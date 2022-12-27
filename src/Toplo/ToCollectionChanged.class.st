Class {
	#name : #ToCollectionChanged,
	#superclass : #Announcement,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToCollectionChanged >> interval [

	^ interval
]

{ #category : #accessing }
ToCollectionChanged >> interval: anInterval [

	interval := anInterval
]

Class {
	#name : #ToObservableListChanged,
	#superclass : #Announcement,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToObservableListChanged >> interval [

	^ interval
]

{ #category : #accessing }
ToObservableListChanged >> interval: anInterval [

	interval := anInterval
]

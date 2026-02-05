Class {
	#name : #ToObservableCollectionEvent,
	#superclass : #BlEvent,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToObservableCollectionEvent >> interval [

	^ interval
]

{ #category : #accessing }
ToObservableCollectionEvent >> interval: anInterval [

	interval := anInterval
]

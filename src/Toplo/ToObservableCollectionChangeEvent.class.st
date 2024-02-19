Class {
	#name : #ToObservableCollectionChangeEvent,
	#superclass : #ToObservableCollectionEvent,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToObservableCollectionChangeEvent >> interval [

	^ interval
]

{ #category : #accessing }
ToObservableCollectionChangeEvent >> interval: anInterval [

	interval := anInterval
]

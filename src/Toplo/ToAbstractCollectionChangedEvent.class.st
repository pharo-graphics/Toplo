Class {
	#name : #ToAbstractCollectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToAbstractCollectionChangedEvent >> interval [

	^ interval
]

{ #category : #accessing }
ToAbstractCollectionChangedEvent >> interval: anInterval [

	interval := anInterval
]

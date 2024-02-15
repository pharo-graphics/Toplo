Class {
	#name : #ToCollectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'interval'
	],
	#category : 'Toplo-Core-Collection'
}

{ #category : #accessing }
ToCollectionChangedEvent >> interval [

	^ interval
]

{ #category : #accessing }
ToCollectionChangedEvent >> interval: anInterval [

	interval := anInterval
]

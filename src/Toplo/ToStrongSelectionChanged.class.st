Class {
	#name : #ToStrongSelectionChanged,
	#superclass : #BlEvent,
	#instVars : [
		'indexes',
		'event'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToStrongSelectionChanged class >> indexes: aCollection event: anEvent [

	^ self new
		  indexes: aCollection;
		  event: anEvent;
		  yourself
]

{ #category : #accessing }
ToStrongSelectionChanged >> event [

	^ event
]

{ #category : #accessing }
ToStrongSelectionChanged >> event: anEvent [

	event := anEvent
]

{ #category : #accessing }
ToStrongSelectionChanged >> indexes [

	^ indexes
]

{ #category : #accessing }
ToStrongSelectionChanged >> indexes: aListOnInteger [

	indexes := aListOnInteger
]

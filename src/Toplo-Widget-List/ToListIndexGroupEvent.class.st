Class {
	#name : #ToListIndexGroupEvent,
	#superclass : #ToListSelectionActionEventDep,
	#instVars : [
		'startIndex',
		'itemCount'
	],
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListIndexGroupEvent class >> isDeprecated [

	^ true
]

{ #category : #accessing }
ToListIndexGroupEvent >> itemCount [

	^ itemCount
]

{ #category : #accessing }
ToListIndexGroupEvent >> itemCount: aNumber [

	itemCount := aNumber
]

{ #category : #printing }
ToListIndexGroupEvent >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ' startIndex: '.
	self startIndex printOn: aStream.
	aStream nextPutAll: ' itemCount: '.
	self itemCount printOn: aStream
]

{ #category : #accessing }
ToListIndexGroupEvent >> startIndex [

	^ startIndex
]

{ #category : #accessing }
ToListIndexGroupEvent >> startIndex: anIndex [

	startIndex := anIndex
]
